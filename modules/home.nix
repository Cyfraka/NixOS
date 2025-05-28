{ config, pkgs, ... }:

{
  # User and Home Directory
  home.username = "cyfraka";
  home.homeDirectory = "/home/cyfraka";


  ##################################################################################
  # GNOME Desktop: Wallpaper
  dconf.settings = {
    "org/gnome/desktop/background" = {
      # Use a portable path referencing homeDirectory
      picture-uri = "file://${config.home.homeDirectory}/.dotfiles/80s.jpg";
      picture-options = "zoom";
    };  
  };

  #Gnome Custom keybindings
  dconf.settings = {
  "org/gnome/settings-daemon/plugins/media-keys" = {
    custom-keybindings = [
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
    ];
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
    name = "Kitty (Win+A)";
    command = "kitty";
    binding = "<Super>a";
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
    name = "Kitty (Win+Enter)";
    command = "kitty";
    binding = "<Super>Return";
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
    name = "Close Window (Win+Q)";
    command = "xdotool getactivewindow windowkill";
    binding = "<Super>q";
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
    name = "Firefox (Win+W)";
    command = "firefox";
    binding = "<Super>w";
    };
  };


  ###################################################################################
  # Git Configuration
  programs.git = {
    enable = true;
    userName = "Cyfraka";
    userEmail = "cyfraka@protonmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };


  ##################################################################################
  # Vim Configuration
  programs.vim = {
    enable = true;
    extraConfig = ''
      set nocompatible
      syntax on
      set shortmess+=I
      set number
      set relativenumber
      set laststatus=2
      set backspace=indent,eol,start
      set hidden
      set ignorecase
      set smartcase
      set incsearch
      nmap Q <Nop>
      set noerrorbells visualbell t_vb=
      set mouse+=a
    '';
  };


  ##################################################################################
  # Kitty Terminal Configuration
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Fira Mono";
      font_size = 10;
      cursor_shape = "underline";
      mouse_hide_wait = 3.0;
      url_prefixes = "http https file ftp";
      detect_urls = "yes";
      copy_on_select = "yes";
      focus_follows_mouse = "yes";
      background_opacity = "0.5";
      hide_window_decorations = "yes";
      confirm_os_window_close = 0;
      enable_audio_bell = "no";
      background = "#0d0f18";
      foreground = "#fffaf3";
      cursor = "#ff0017";
      selection_background = "#002a3a";
      selection_foreground = "#0d0f18";
      color0  = "#222222"; color8  = "#444444";
      color1  = "#ff000f"; color9  = "#ff273f";
      color2  = "#8ce00a"; color10 = "#abe05a";
      color3  = "#ffb900"; color11 = "#ffd141";
      color4  = "#008df8"; color12 = "#0092ff";
      color5  = "#6c43a5"; color13 = "#9a5feb";
      color6  = "#00d7eb"; color14 = "#67ffef";
      color7  = "#ffffff"; color15 = "#ffffff";
      # Uncomment and set your preferred shell:
      # shell = "bash -l -c 'fastfetch; exec bash -l'";
      # shell = "zsh -l -c 'fastfetch; exec zsh -l'";
    };
  };
  ###################################################################################
  # Bash Configuration
  programs.bash = {
    enable = true;
    shellAliases = {
      ssh = ''[[ "$TERM" == "xterm-kitty" ]] && kitty +kitten ssh || ssh'';
    };
    sessionVariables = {
      # Uncomment below to set system pager
      # SYSTEMD_PAGER = "";
    };
    bashrcExtra = ''
      # Source global definitions
      if [ -f /etc/bashrc ]; then
        . /etc/bashrc
      fi

      # User specific environment
      if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
      then
          PATH="$HOME/.local/bin:$HOME/bin:$PATH"
      fi
      export PATH

      # Kitty SSH fix
      [[ "$TERM" == "xterm-kitty" ]] && alias ssh="kitty +kitten ssh"

      # User specific aliases and functions from ~/.bashrc.d
      if [ -d ~/.bashrc.d ]; then
        for rc in ~/.bashrc.d/*; do
          if [ -f "$rc" ]; then
            . "$rc"
          fi
        done
      fi
      unset rc

      # Custom prompt
      PS1='[\t \[\e[01;34m\]\u\[\e[0m\]@\[\e[01;34m\]\h\[\e[0m\] \W]\$ '

      # Tmux auto-attach on SSH
      if [[ -n "$PS1" ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_CONNECTION" ]]; then
        tmux attach-session -t XMR || tmux new-session -s XMR
      fi

      # Fastfetch info tool
      fastfetch
    '';
  };


  ################################################################################
  # Tmux Configuration
  programs.tmux = {
    enable = true;
    extraConfig = ''
      # Prefix
      set-option -g prefix C-a
      unbind-key C-a
      bind-key C-a send-prefix

      # Pane switching (Alt+Arrows)
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Window switching (Shift+Arrows)
      bind -n S-Left previous-window
      bind -n S-Right next-window

      # Mouse mode
      setw -g mouse on

      # Status bar color
      set-option -g status-style bg=blue

      # Window split keys
      bind-key v split-window -h
      bind-key h split-window -v

      # Reload config
      bind-key r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded."
    '';
  };


  ##################################################################################
  # Home Manager Release Version
  home.stateVersion = "25.11";

  # User Packages (Uncomment to add more)
  home.packages = [
    # pkgs.hello
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    # (pkgs.writeShellScriptBin "my-hello" "echo Hello, ${config.home.username}!")
  ];

  # Dotfiles and custom files
  home.file = {
    # ".screenrc".source = "${config.home.homeDirectory}/.dotfiles/screenrc";
    # ".vimrc".source = "${config.home.homeDirectory}/.dotfiles/vimrc";
    # Example for direct file content:
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Session variables managed by Home Manager
  home.sessionVariables = {
    # Uncomment and set as needed
    EDITOR = "vim";
  };

  # Enable Home Manager to manage itself
  programs.home-manager.enable = true;
}
