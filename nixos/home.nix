{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  imports = [
    "${fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master"}/modules/vscode-server/home.nix"
  ];

  services.vscode-server.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    (pkgs.callPackage ./fzf.nix { })

    pkgs.curl
    pkgs.emacs
    pkgs.emacs-all-the-icons-fonts
    pkgs.exercism
    pkgs.fd
    pkgs.file
    pkgs.fortune
    pkgs.gnumake 
    pkgs.htop
    pkgs.inotify-tools
    pkgs.killall
    pkgs.lsof
    pkgs.neovim
    pkgs.nerdfonts
    pkgs.ngrok
    # needed for copilot
    pkgs.nodejs
    pkgs.python3
    pkgs.ripgrep
    pkgs.rlwrap
    pkgs.thefuck
    pkgs.tree
    pkgs.unzip
    pkgs.wget
    pkgs.zip
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
  home.file.".zshrc".source = /home/nixos/workspace/dotfiles/zshrc;
  home.file.".tmux.conf".source = /home/nixos/workspace/dotfiles/tmux.conf;
  home.file.".config/doom/config.el".source = /home/nixos/workspace/dotfiles/doom.d/config.el;
  home.file.".config/doom/init.el".source = /home/nixos/workspace/dotfiles/doom.d/init.el;
  home.file.".config/doom/packages.el".source = /home/nixos/workspace/dotfiles/doom.d/packages.el;
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink /home/nixos/workspace/dotfiles/nvim;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/fontconfig/fonts.conf".text = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <dir>/mnt/c/Windows/Fonts</dir>
        <dir>/mnt/c/Users/monte/AppData/Local/Microsoft/Windows/Fonts/</dir>
      </fontconfig>
    '';
  };

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

