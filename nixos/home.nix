{ config, pkgs, lib, ... }:

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
  home.stateVersion = "25.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  imports = [
    "${fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master"}/modules/vscode-server/home.nix"
  ];

  services.vscode-server.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.anki
    pkgs.awscli2
    pkgs.bazecor
    pkgs.brave
    pkgs.curl
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
    pkgs.ghostty
    pkgs.gimp
    pkgs.gitflow 
    pkgs.gnumake 
    pkgs.htop
    pkgs.i3-resurrect
    pkgs.inotify-tools
    # TODO java should not be global
    pkgs.jdk21
    pkgs.killall
    pkgs.libreoffice-qt
    # TODO localstack should not be global
    pkgs.localstack
    pkgs.lsof
    pkgs.maim
    pkgs.ncdu
    pkgs.nemo
    pkgs.neovim
    pkgs.nerdfonts
    pkgs.ngrok
    # needed for copilot
    pkgs.nodejs
    pkgs.obsidian
    pkgs.openvpn
    pkgs.pasystray
    pkgs.pavucontrol
    # TODO this should not be here! Make it work with direnv
    pkgs.python3
    pkgs.ripgrep
    pkgs.rlwrap
    pkgs.rofi
    pkgs.slack
    pkgs.telegram-desktop
    pkgs.thefuck
    pkgs.thunderbird
    pkgs.tree
    pkgs.unzip
    pkgs.usbutils
    pkgs.rxvt-unicode
    pkgs.xclip
    pkgs.wget
    pkgs.zenity
    pkgs.zip
    pkgs.zoom-us
    pkgs.zsh
    pkgs.z-lua

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "SourceCodePro" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # these are outside home.file because they're bigger than a few lines
  home.file.".zshrc".source = /home/lazywithclass/workspace/dotfiles/zshrc;
  home.file.".tmux.conf".source = /home/lazywithclass/workspace/dotfiles/tmux.conf;
  home.file.".config/doom/config.el".source = /home/lazywithclass/workspace/dotfiles/doom.d/config.el;
  home.file.".config/doom/init.el".source = /home/lazywithclass/workspace/dotfiles/doom.d/init.el;
  home.file.".config/doom/packages.el".source = /home/lazywithclass/workspace/dotfiles/doom.d/packages.el;
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink /home/lazywithclass/workspace/dotfiles/nvim;
  home.file.".config/i3/config".source = /home/lazywithclass/workspace/dotfiles/i3/config;
  home.file.".config/i3/help".source = /home/lazywithclass/workspace/dotfiles/i3/help;
  home.file.".config/nixpkgs/config.nix".source = /home/lazywithclass/workspace/dotfiles/nixos/nixpkgs-config.nix;
  home.file.".Xresources".source = /home/lazywithclass/workspace/dotfiles/Xresources;

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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # programs.nix-ld.enable = true;

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
    userName = "Alberto Zaccagni";
    userEmail = "montecristoh@gmail.com";
  };

  programs.tmux = {
    enable = true;
    extraConfig = ''
      run-shell ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/resurrect.tmux
    '';
  };

}

