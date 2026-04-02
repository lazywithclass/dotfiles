# claude-remote-control.nix
#
# Home Manager module that keeps a Claude Code session alive with remote-control
# enabled, so you can connect from the Claude mobile app or claude.ai/code.
#
# Architecture:
#   systemd user service → tmux session → claude --remote-control
#
# Usage: import this from your home.nix and ensure claude-code is in your PATH.

{ config, pkgs, lib, claude-code-nix, ... }:

let
  claudePkg = claude-code-nix.packages.${pkgs.system}.default;

  # Script that starts claude in a tmux session with remote-control.
  # If the tmux session already exists (e.g., after a restart race), 
  # we kill it first to avoid stale sessions.
  startScript = pkgs.writeShellScript "claude-remote-start" ''
    export PATH="${lib.makeBinPath [ pkgs.tmux claudePkg pkgs.coreutils ]}:$PATH"

    # Load API key and any other env vars
    ENV_FILE="''${HOME}/.config/claude/env"
    if [ -f "$ENV_FILE" ]; then
      set -a
      source "$ENV_FILE"
      set +a
    fi

    # Kill stale session if it exists
    tmux kill-session -t claude-rc 2>/dev/null || true

    # Start a detached tmux session running claude with remote-control
    # Using exec so tmux becomes the main process for the service
    exec tmux new-session -d -s claude-rc \
      "claude --remote-control; echo 'Claude exited. Press enter to restart...'; read"
  '';

  stopScript = pkgs.writeShellScript "claude-remote-stop" ''
    export PATH="${lib.makeBinPath [ pkgs.tmux ]}:$PATH"
    tmux kill-session -t claude-rc 2>/dev/null || true
  '';

  healthScript = pkgs.writeShellScript "claude-remote-health" ''
    export PATH="${lib.makeBinPath [ pkgs.tmux ]}:$PATH"
    tmux has-session -t claude-rc 2>/dev/null
  '';
in
{
  # Install claude-code
  home.packages = [ claudePkg ];

  # Persistent claude remote-control session
  systemd.user.services.claude-remote-control = {
    Unit = {
      Description = "Persistent Claude Code remote-control session";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };

    Service = {
      Type = "forking";
      ExecStart = "${startScript}";
      ExecStop = "${stopScript}";
      ExecCondition = "!${healthScript}";  # Don't start if already running
      Restart = "on-failure";
      RestartSec = 10;

      # Give claude time to cleanly shut down
      TimeoutStopSec = 15;

      # Ensure XDG dirs and DISPLAY/WAYLAND are available if needed
      Environment = [
        "HOME=%h"
      ];
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # Timer to check health and restart if the tmux session died
  # but systemd didn't notice (belt-and-suspenders)
  systemd.user.services.claude-remote-watchdog = {
    Unit = {
      Description = "Watchdog for Claude Code remote-control session";
    };

    Service = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "claude-watchdog" ''
        export PATH="${lib.makeBinPath [ pkgs.tmux pkgs.systemd ]}:$PATH"
        if ! tmux has-session -t claude-rc 2>/dev/null; then
          echo "Claude remote-control tmux session not found. Restarting service..."
          systemctl --user restart claude-remote-control.service
        fi
      '';
    };
  };

  systemd.user.timers.claude-remote-watchdog = {
    Unit = {
      Description = "Check Claude remote-control is alive every 5 minutes";
    };

    Timer = {
      OnBootSec = "2min";
      OnUnitActiveSec = "5min";
      Unit = "claude-remote-watchdog.service";
    };

    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
