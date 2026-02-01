{ config, pkgs, lib, ... }:

let
  pkgsUnstable = import (builtins.fetchTarball {
    url = "https://github.com/nixos/nixpkgs/archive/nixos-unstable.tar.gz";
  }) {
    # inherit my current config (importantly: allowUnfree = true)
    config = config.nixpkgs.config; 
  };

  # Anki
  ankiCommit = "87848bf0cc4f87717fc813a4575f07330c3e743c";
  ankiSrc = builtins.fetchTarball {
    url = "https://github.com/nixos/nixpkgs/archive/${ankiCommit}.tar.gz";
  };
  pkgsAnki = import ankiSrc { config = config.nixpkgs.config; };

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

  imports = [
    # "${fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master"}/modules/vscode-server/home.nix"
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

    pkgs.awscli2
    pkgs.bazecor
    pkgs.brave
    pkgs.curlFull
    pkgs.clojure-lsp # TODO should not be global
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
    pkgs.git-lfs
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
    pkgs.localstack # TODO localstack should not be global
    pkgs.lsof
    pkgs.maim
    pkgs.mpv
    pkgs.ncdu
    pkgs.nemo
    pkgs.nemo-fileroller
    pkgs.neovim
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
    pkgs.python3 # TODO this should not be here! Make it work with direnv
    pkgs.rclone
    pkgs.ripgrep
    pkgs.rlwrap
    pkgs.slack
    pkgs.telegram-desktop
    pkgs.thunderbird
    pkgs.tree
    pkgs.unzip
    pkgs.usbutils
    pkgs.rxvt-unicode
    pkgs.xclip
    pkgs.xfce.exo 
    pkgs.xorg.xhost
    pkgs.xorg.xkill
    pkgs.vscode
    pkgs.wget
    pkgs.zenity
    pkgs.zip
    pkgs.zoom-us
    pkgs.z-lua

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

  ];

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

  home.file.".npmrc".text = ''
    prefix=/home/lazywithclass/.npm-global
  '';
  home.activation.installCopilotLanguageServer = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.nodejs_22}/bin/npm install -g @github/copilot-language-server
  '';

  # Beads
  home.activation.installBeads = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH="${pkgs.go}/bin:${pkgs.gcc}/bin:$PATH"
    export CGO_ENABLED=1
    export CC="${pkgs.gcc}/bin/gcc"
    export CXX="${pkgs.gcc}/bin/g++"
    export CGO_CFLAGS="-I${pkgs.icu.dev}/include"
    export CGO_CXXFLAGS="-I${pkgs.icu.dev}/include"
    export CGO_LDFLAGS="-L${pkgs.icu}/lib -licuuc -licui18n -licudata"
    export GOPATH="$HOME/go"
    export GOBIN="$HOME/go/bin"
    ${pkgs.go}/bin/go install github.com/steveyegge/beads/cmd/bd@latest
  '';
  # Perles, beads UI
  home.activation.installPerles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH="${pkgs.go}/bin:${pkgs.gcc}/bin:$PATH"
    export CGO_ENABLED=1
    export CC="${pkgs.gcc}/bin/gcc"
    export CXX="${pkgs.gcc}/bin/g++"
    export CGO_CFLAGS="-I${pkgs.icu.dev}/include"
    export CGO_CXXFLAGS="-I${pkgs.icu.dev}/include"
    export CGO_LDFLAGS="-L${pkgs.icu}/lib -licuuc -licui18n -licudata"
    export GOPATH="$HOME/go"
    export GOBIN="$HOME/go/bin"
    ${pkgs.go}/bin/go install github.com/zjrosen/perles@latest
  '';

  # these are outside home.file because they're bigger than a few lines
  # !!! zshrc is defined below
  # home.file.".zshrc".source = /home/lazywithclass/workspace/dotfiles/zshrc;
  home.file.".config/doom/config.el".source = /home/lazywithclass/workspace/dotfiles/doom.d/config.el;
  home.file.".config/doom/init.el".source = /home/lazywithclass/workspace/dotfiles/doom.d/init.el;
  home.file.".config/doom/packages.el".source = /home/lazywithclass/workspace/dotfiles/doom.d/packages.el;
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink /home/lazywithclass/workspace/dotfiles/nvim;
  home.file.".config/i3/config".source = /home/lazywithclass/workspace/dotfiles/i3/config;
  home.file.".config/i3/help".source = /home/lazywithclass/workspace/dotfiles/i3/help;
  home.file.".config/nixpkgs/config.nix".source = /home/lazywithclass/workspace/dotfiles/nixos/nixpkgs-config.nix;

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Monaco" "Symbols Nerd Font Mono" ];
      sansSerif = [ "Inter" "DejaVu Sans" ];
      serif = [ "DejaVu Serif" ];
    };
  };

  # Install Monaco.ttf into ~/.local/share/fonts
  home.file.".local/share/fonts/Monaco.ttf".source =
    config.lib.file.mkOutOfStoreSymlink
      /home/lazywithclass/.config/home-manager/Monaco_Linux.ttf;

  # for Brave
  gtk = {
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
    settings.user = {
      name = "Alberto Zaccagni";
      email = "montecristoh@gmail.com";
    };
    lfs.enable = true;
  };

  programs.ghostty = {
    enable = true;
    settings = {
      window-padding-x = 10;
      window-decoration = "none";
    };
  };

  programs.rofi = {
    enable = true;
    plugins = [ pkgs.rofi-file-browser ];
    extraConfig = {
      show-icons = true;
    };
  };

  programs.tmux = {
    enable = true;
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

# disable "release mouse drag to copy and exit copy-mode", ref: https://github.com/tmux/tmux/issues/140
unbind-key -T copy-mode-vi MouseDragEnd1Pane

# since MouseDragEnd1Pane neither exit copy-mode nor clear selection now,
# let single click do selection clearing for us.
bind-key -T copy-mode-vi MouseDown1Pane select-pane\; send-keys -X clear-selection

# this line changes the default binding of MouseDrag1Pane, the only difference
# is that we use `copy-mode -eM` instead of `copy-mode -M`, so that WheelDownPane
# can trigger copy-mode to exit when copy-mode is entered by MouseDrag1Pane
bind -n MouseDrag1Pane if -Ft= '#{mouse_any_flag}' 'if -Ft= \"#{pane_in_mode}\" \"copy-mode -eM\" \"send-keys -M\"' 'copy-mode -eM'

set -g @yank_action 'copy-pipe'

########## UI ##########
set -g default-terminal "screen-256color" # colors!
set -g @themepack 'basic'

########## BINDINGS ##########
bind j resize-pane -D 10
bind k resize-pane -U 10
bind h resize-pane -L 10
bind l resize-pane -R 10
bind-key C-a last-window
bind-key R source-file ~/.tmux.conf; display-message "~/.tmux.conf is reloaded"
bind '"' split-window -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"
bind c new-window -c "#{pane_current_path}"
bind > swap-pane -D       # swap current pane with the next one
bind < swap-pane -U       # swap current pane with the previous one

########## PLUGINS ##########
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'jimeh/tmux-themepack'
set -g @plugin 'nhdaly/tmux-better-mouse-mode'
set -g @plugin 'tmux-plugins/tmux-yank'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
    '';
  };

  programs.zsh = {
    enable = true;
    initExtra = ''
      export LD_LIBRARY_PATH="${lib.makeLibraryPath [pkgs.icu pkgs.pipewire.jack]}"
      source /home/lazywithclass/workspace/dotfiles/zshrc
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

}

