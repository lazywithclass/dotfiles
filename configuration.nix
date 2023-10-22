{ lib, pkgs, config, modulesPath, ... }:

with lib;
let
  nixos-wsl = import ./nixos-wsl;
in
{
  imports = [
    "${modulesPath}/profiles/minimal.nix"
    <home-manager/nixos>
    nixos-wsl.nixosModules.wsl
    (fetchTarball "https://github.com/nix-community/nixos-vscode-server/tarball/master")
  ];

  wsl = {
    enable = true;
    automountPath = "/mnt";
    defaultUser = "nixos";
    startMenuLaunchers = true;

    # Enable native Docker support
    docker-native.enable = true;

    # Enable integration with Docker Desktop (needs to be installed)
    docker-desktop.enable = true;
  };

  # is this needed for ngrok?
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 19000 ];
    allowedUDPPortRanges = [
      { from = 4000; to = 4007; }
      { from = 8000; to = 8010; }
    ];
  };

  # Enable nix flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    keep-outputs = true
    keep-derivations = true
  '';

  # https://github.com/nix-community/nixos-vscode-server#installation
  services.vscode-server.enable = true;

  # dont know why I had to add this line, it's already specified below  
  # programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  fonts.fonts = with pkgs; [
    fira-code
    fira-code-symbols
  ];

  home-manager.users.nixos = { pkgs, ... }: {

    home.username = "nixos";
    home.homeDirectory = "/home/nixos";
    home.stateVersion = "22.05";

    home.sessionVariables = {
      NIX_SHELL_PRESERVE_PROMPT=1;
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    home.packages = [
      pkgs.curl
      pkgs.emacs
      pkgs.fd
      pkgs.file
      pkgs.fortune
      pkgs.gnumake 
      pkgs.htop
      pkgs.killall
      pkgs.lsof
      pkgs.ripgrep
      pkgs.tree
      pkgs.unzip
      pkgs.wget
      pkgs.z-lua
    ];

    # symlinks
    home.file.".zshrc".source = /home/nixos/workspace/dotfiles/zshenv;
    home.file.".tmux.conf".source = /home/nixos/workspace/dotfiles/tmux.conf;
    home.file.".config/doom/config.el".source = /home/nixos/workspace/dotfiles/doom.d/config.el;
    home.file.".config/doom/init.el".source = /home/nixos/workspace/dotfiles/doom.d/init.el;
    home.file.".config/doom/packages.el".source = /home/nixos/workspace/dotfiles/doom.d/packages.el;

    programs.tmux = {
      enable = true;
      extraConfig = ''
        run-shell ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/resurrect.tmux
      '';
    };

    programs.vim = {
      enable = true;  
      extraConfig = ''
        syntax on
      '';
    };

    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
      ];
    };

    programs.git = {
      enable = true;
      userName = "Alberto Zaccagni";
      userEmail = "montecristoh@gmail.com";
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    programs.zsh = {
      enable = true;
      shellAliases = {
        update = "sudo nixos-rebuild switch";
      };
      history = {
        size = 10000;
        path = ".zsh_history";
      };
      enableAutosuggestions = true;
      oh-my-zsh = {
        enable = false;
        plugins = [];
        theme = "robbyrussell";
      };
    };

    programs.bat = {
      enable = true;
      config = {
      };
    };
  };

  time.timeZone = "Europe/Rome";

  system.stateVersion = "22.05";
}
