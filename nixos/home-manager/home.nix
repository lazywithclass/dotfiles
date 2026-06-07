{ config, pkgs, lib, claude-desktop, pkgsAnki, ... }:

let
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "lazywithclass";
  home.homeDirectory = "/home/lazywithclass";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    claude-desktop.overlays.default
    (final: prev: {
      python3 = prev.python3.override {
        packageOverrides = pyfinal: pyprev: {
          plux = pyprev.plux.overridePythonAttrs (old: {
            doCheck = false;
          });
        };
      };
    })
    (final: prev: {
      rtk = prev.rustPlatform.buildRustPackage {
        pname = "rtk";
        version = "0.35.0";
        src = prev.fetchFromGitHub {
          owner = "rtk-ai";
          repo = "rtk";
          rev = "v0.35.0";
          hash = "sha256-7DAL4dsnq2ZWmkyoI+BeN21ouK0VyLvSxOCt5hPWCl4=";
        };
        cargoHash = "sha256-r/PCA15MsmERCq3z8nObxdbX3KijsrInxsgJ6aqRVc4=";
        doCheck = false;
      };
    })
  ];

  imports = [
    # "${fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master"}/modules/vscode-server/home.nix"
    ./claude-remote-control.nix # provides claude code
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    (pkgs.symlinkJoin {
      name = "anki";
      paths = [ pkgsAnki.anki ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/anki \
          --set QTWEBENGINE_CHROMIUM_FLAGS "--use-gl=disabled"
      '';
    })
    pkgs.claude-desktop
    pkgs.codex
    pkgs.crush
    pkgs.lmstudio
    pkgs.rtk
    pkgs.zed-editor

    pkgs.awscli2
    pkgs.bazecor
    pkgs.brave
    pkgs.curlFull
    pkgs.cljfmt # TODO should not be global?
    pkgs.clojure-lsp # TODO should not be global?
    pkgs.dbeaver-bin
    pkgs.discord
    pkgs.docker-compose
    pkgs.emacs
    pkgs.emacs-all-the-icons-fonts
    pkgs.exercism
    pkgs.expect
    pkgs.fd
    pkgs.ffmpeg
    pkgs.file
    pkgs.fortune
    pkgs.fzf	
    pkgs.gcc
    pkgs.gimp
    pkgs.gitflow 
    pkgs.gnumake 
    pkgs.gopass
    pkgs.haskellPackages.greenclip
    pkgs.htop
    pkgs.i3-resurrect
    pkgs.icu
    pkgs.inotify-tools
    pkgs.inter # font
    pkgs.jdk21 # TODO java should not be global
    pkgs.jq
    pkgs.killall
    pkgs.leiningen # TODO should not be global
    pkgs.libreoffice-qt
    pkgs.lsof
    pkgs.maim
    pkgs.mpv
    pkgs.ncdu
    pkgs.neovim
    pkgs.nemo
    pkgs.nemo-fileroller
    pkgs.nerd-fonts.symbols-only
    pkgs.ngrok
    pkgs.nodejs_22 # needed for copilot
    pkgs.noto-fonts-cjk-sans
    pkgs.obsidian
    pkgs.openvpn
    pkgs.pandoc
    pkgs.p7zip
    pkgs.pasystray
    pkgs.pavucontrol
    pkgs.pkg-config
    pkgs.playerctl
    pkgs.python3 # TODO this should not be here! Make it work with direnv
    pkgs.qbittorrent
    pkgs.rclone
    pkgs.ripgrep
    pkgs.rlwrap
    pkgs.semgrep
    pkgs.sox
    pkgs.telegram-desktop
    pkgs.thunderbird
    pkgs.tree
    pkgs.unzip
    pkgs.usbutils
    pkgs.rxvt-unicode
    pkgs.xclip
    pkgs.xfce4-exo 
    pkgs.xhost
    pkgs.xkill
    pkgs.xkill
    pkgs.vscode
    pkgs.wget
    pkgs.wgnord
    pkgs.zenity
    pkgs.zip
    pkgs.zoom-us
    pkgs.z-lua
  ];

  # xdg.enable = true;

  home.file.".clojure/deps.edn".text = ''
    {:aliases
      {:deps-new
        {:replace-deps {io.github.seancorfield/deps-new
                        {:git/tag "v0.11.1" :git/sha "FIXME"}}
         :ns-default org.corfield.new}

       :storm
        {:classpath-overrides {org.clojure/clojure nil}
         :extra-deps {com.github.flow-storm/clojure       {:mvn/version "1.12.5"}
                      com.github.flow-storm/flow-storm-dbg {:mvn/version "4.5.9"}}
         :jvm-opts ["-Dflowstorm.startRecording=false"
                    "-Dclojure.storm.instrumentEnable=true"
                    "-Dclojure.storm.instrumentAutoPrefixes=true"]}}}
  '';

  xdg.dataFile."nemo/actions/compress.nemo_action".text = ''
    [Nemo Action]
    Active=true
    Name=Compress...
    Comment=compress %N
    Exec=file-roller -d %F
    Icon-Name=gnome-mime-application-x-compress
    Selection=Any
    Extensions=any;
  '';

  xdg.dataFile."nemo/actions/extracthere.nemo_action".text = ''
    [Nemo Action]
    Active=true
    Name=Extract here
    Comment=Extract here
    Exec=file-roller -h %F
    Icon-Name=gnome-mime-application-x-compress
    #Stock-Id=gtk-cdrom
    Selection=Any
    Extensions=zip;7z;ar;cbz;cpio;exe;iso;jar;tar;tar;7z;tar.Z;tar.bz2;tar.gz;tar.lz;tar.lzma;tar.xz;
  '';

  home.file.".claude/settings.json".text = builtins.toJSON {
    model = "opus";
    permissions = {
      allow = [
        "Read"
        "Glob"
        "Grep"
        "WebFetch"
        "WebSearch"
      ];
    };
    hooks = {
      PreToolUse = [
        {
          matcher = "Bash";
          hooks = [
            {
              type = "command";
              command = "/home/lazywithclass/.claude/hooks/rtk-rewrite.sh";
            }
          ];
        }
      ];
    };
    effortLevel = "high";
  };

  home.file.".npmrc".text = ''
    prefix=/home/lazywithclass/.npm-global
  '';
  home.activation.installCopilotLanguageServer = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.nodejs_22}/bin/npm install -g @github/copilot-language-server
  '';

  home.file.".config/brave-flags.conf".text = ''
    --enable-features=GlobalMediaControls,MediaSessionService
  '';

  home.activation.installDoom = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    DOOM="${config.home.homeDirectory}/.config/emacs"
    if [ ! -d "$DOOM" ]; then
      ${pkgs.git}/bin/git clone --depth=1 https://github.com/doomemacs/doomemacs "$DOOM"
      PATH="${pkgs.git}/bin:${pkgs.emacs}/bin:$PATH" "$DOOM/bin/doom" install --no-config
    fi
  '';

  # these are outside home.file because they're bigger than a few lines
  # !!! zshrc is defined below
  # home.file.".zshrc".source = /home/lazywithclass/workspace/dotfiles/zshrc;
  home.file.".config/doom/config.el".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/workspace/dotfiles/doom.d/config.el";
  home.file.".config/doom/init.el".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/workspace/dotfiles/doom.d/init.el";
  home.file.".config/doom/packages.el".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/workspace/dotfiles/doom.d/packages.el";
  home.file.".config/i3/config".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/workspace/dotfiles/i3/config";
  home.file.".config/i3/startup-layouts.sh".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/workspace/dotfiles/i3/startup-layouts.sh";
  home.file.".config/i3/help".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/workspace/dotfiles/i3/help";
  home.file.".config/i3blocks/config".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/workspace/dotfiles/i3blocks/config";
  home.file.".config/nixpkgs/config.nix".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/workspace/dotfiles/nixos/nixpkgs-config.nix";
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/workspace/dotfiles/nvim";

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Monaco" "Symbols Nerd Font Mono" ];
      sansSerif = [ "Inter" "DejaVu Sans" ];
      serif = [ "DejaVu Serif" ];
    };
  };

  home.file.".local/share/fonts/Monaco.ttf".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.config/home-manager/Monaco_Linux.ttf";

  # for Brave
  gtk = {
    gtk4.theme = null; # silence stateVersion < 26.05 warning
    enable = true;
    font = {
      name = "Inter";
      size = 10;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      # ADD THESE LINES TO FIX PIXELATION
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };
  };

  xresources.properties = {
    "Xft.dpi" = 96;
    "Xft.antialias" = 1;
    "Xft.hinting" = 1;
    "Xft.hintstyle" = "hintslight";
    "Xft.rgba" = "rgb";
  };

  xsession.windowManager.i3.config.startup = [
    { command = "xset s off -dpms"; notification = false; }
  ];

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/nixos/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "vim";
  };
  home.sessionPath = [ "${config.home.homeDirectory}/.config/emacs/bin" ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bat = {
    enable = true;
    config = {
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
       name = "Alberto Zaccagni";
       email = "montecristoh@gmail.com";
      };
    };
    lfs.enable = true;
  };

  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    # themeFile = "Adapta_Nokto_Maia";
    themeFile = "Doom_One";
    settings = {
      enable_audio_bell = false;
      hide_window_decorations = true;
    };
  };

  programs.opencode = {
    enable = true;
    package = pkgs.opencode;
    
    settings = {
      permission = {
        # Global default - require approval for everything
        "*" = "ask";
        
        # File reading - allow most, deny .env files
        read = {
          "*" = "allow";
          "*.env" = "deny";
          "*.env.*" = "deny";
          "*.env.example" = "allow";
        };
        
        # File editing - ask for approval
        edit = {
          "*" = "ask";
          # Allow editing specific paths without prompt
          "src/**" = "allow";
          # Block editing certain files entirely
          "*.lock" = "deny";
        };
        
        # Shell commands - granular control
        bash = {
          "*" = "ask";
          "git status *" = "allow";
          "git diff *" = "allow";
          "git log *" = "allow";
          "git branch *" = "allow";
          "grep *" = "allow";
          "rg *" = "allow";
          "ls *" = "allow";
          "cat *" = "allow";
          "head *" = "allow";
          "tail *" = "allow";
          # Dangerous commands - always deny or ask
          "rm -rf *" = "deny";
          "git push *" = "ask";
          "git commit *" = "ask";
          "sudo *" = "deny";
        };
        
        # External directories (outside project root)
        external_directory = {
          "*" = "deny";
          "~/workspace/*" = "ask";
        };
        
        # Other tools
        webfetch = "allow";
        websearch = "allow";
        glob = "allow";
        grep = "allow";
        list = "allow";
        lsp = "allow";
        task = "ask";  # subagent launching
	todowrite = "allow";
      };
    };
  };

  programs.rofi = {
    enable = true;
    plugins = [ pkgs.rofi-file-browser ];
    extraConfig = {
      show-icons = true;
    };
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        serverAliveInterval = 60;
        serverAliveCountMax = 3;
      };
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519_github";
        addKeysToAgent = "yes";
      };
    };
    enableDefaultConfig = false;
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    extraConfig = ''
run-shell ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/resurrect.tmux

set-option -g prefix C-a
set-option -g default-shell ~/.nix-profile/bin/zsh
set -g base-index 1
setw -g pane-base-index 1

# TODO TEST THE ESCAPE TIME
set -s escape-time 1
set -g history-limit 50000

set-option -g mouse on

set -g status-justify left
set -g status-right '#(date +%%H:%%M) '

# from https://github.com/NHDaly/tmux-better-mouse-mode
set -g @scroll-speed-num-lines-per-scroll "1" 

########## UI ##########
set -g default-terminal "tmux-256color"
set -ga terminal-overrides ",*256col*:Tc"
set -g @themepack 'basic'

########## PLUGINS ##########
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'jimeh/tmux-themepack'
set -g @plugin 'nhdaly/tmux-better-mouse-mode'
set -g @plugin 'tmux-plugins/tmux-yank'

set -g @resurrect-capture-pane-contents 'on'

set -g @yank_action 'copy-pipe-no-clear'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'

########## BINDINGS ##########
bind j resize-pane -D 10
bind k resize-pane -U 10
bind h resize-pane -L 10
bind l resize-pane -R 10
bind-key C-a last-window
bind-key R source-file ~/.config/tmux/tmux.conf; display-message "~/.tmux.conf is reloaded"
bind '"' split-window -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"
bind c new-window -c "#{pane_current_path}"
bind > swap-pane -D       # swap current pane with the next one
bind < swap-pane -U       # swap current pane with the previous one
bind -n MouseDrag1Pane if -Ft= '#{mouse_any_flag}' 'if -Ft= "#{pane_in_mode}" "copy-mode -M" "send-keys -M"' 'copy-mode -M'
bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-no-clear "xclip -selection clipboard -i"
bind-key -T copy-mode-vi MouseDown1Pane select-pane \; send-keys -X clear-selection
    '';
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "z" ];
      extraConfig = ''
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#606060"
      '';
    };
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
    ];
    initContent = ''
      export LD_LIBRARY_PATH="${lib.makeLibraryPath [pkgs.icu pkgs.pipewire.jack]}"
      source /home/lazywithclass/workspace/dotfiles/zshrc

      nordvpn() {
        sudo ${pkgs.wgnord}/bin/wgnord "$@"
        case "$1" in
          connect|up)   echo "''${2:-unknown}" > ~/.nordvpn_region ;;
          disconnect|down) echo "disconnected" > ~/.nordvpn_region ;;
        esac
        }
    '';
  };

  services.dunst = {
    enable = true;
    # for hints
    # https://github.com/Yutsuten/linux-config/blob/f371d907e1d00c633b9d0da1579bef8802e3c0c3/desktop/dunstrc.conf
    settings = {
      global = {
        monitor = 0;
	notification-limit = 5;
	font = "Monaco 15";
      };
      urgency_low = {
        timeout = 5;
      };
      urgency_normal = {
	timeout = 5;
      };
      urgency_critical = {
	timeout = 0;
      };
    };
  };

  services.unclutter = {
    enable = true;
    package = pkgs.unclutter-xfixes;
    timeout = 1;   # seconds idle before hiding
    threshold = 5; # pixels of movement to "wake" it
    extraOptions = [ "ignore-scrolling" ];
  };
}

