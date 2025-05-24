{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cyfraka";
  home.homeDirectory = "/home/cyfraka";

  # Gnome Wallpaper 80s
  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri = "file://home/Cyfraka/.dotfiles/80s.jpg";
      picture-options = "zoom"; # or "centered", "scaled", etc.
    };
  };

  # Gnome Profile Pic Cyfraka
  #home.file."cyfraka-profile.jpg".source = home/Cyfraka/.dotfiles/Cyfraka.jpg;

  #GIT Settings
  programs.git = {
    enable = true;
    userName = "Cyfraka";
    userEmail = "cyfraka@protonmail.com";
    extraConfig = {
      init.defaultBrnch = "main";
    };
  };

  #VIM Settings
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

  #KITTY Settings
  programs.kitty = {
    enable = true;
    settings = {
      # Fonts
      font_family = "Fira Mono";
      font_size = 10;

      # Cursor
      cursor_shape = "underline";

      # Mouse and Selection
      mouse_hide_wait = 3.0;
      url_prefixes = "http https file ftp";
      detect_urls = "yes";
      copy_on_select = "yes";
      focus_follows_mouse = "yes";

      # Window & Appearance
      background_opacity = "0.5";
      hide_window_decorations = "yes";
      confirm_os_window_close = 0;

      # Terminal Bell
      enable_audio_bell = "no";

      # Color scheme (Argonaut)
      background = "#0d0f18";
      foreground = "#fffaf3";
      cursor = "#ff0017";
      selection_background = "#002a3a";
      color0  = "#222222";
      color8  = "#444444";
      color1  = "#ff000f";
      color9  = "#ff273f";
      color2  = "#8ce00a";
      color10 = "#abe05a";
      color3  = "#ffb900";
      color11 = "#ffd141";
      color4  = "#008df8";
      color12 = "#0092ff";
      color5  = "#6c43a5";
      color13 = "#9a5feb";
      color6  = "#00d7eb";
      color14 = "#67ffef";
      color7  = "#ffffff";
      color15 = "#ffffff";
      selection_foreground = "#0d0f18";


      # If you use bash:
      #shell = "bash -l -c 'fastfetch; exec bash -l'";

      # If you use zsh, change to:
      # shell = "zsh -l -c 'fastfetch; exec zsh -l'";

      };
    };

  # BashRC Settings
  programs.bash = {
    enable = true;

    # Set up aliases
    shellAliases = {
      # Kitty SSH fix
      ssh = ''[[ "$TERM" == "xterm-kitty" ]] && kitty +kitten ssh || ssh'';
    };

    # Set session variables or env
    sessionVariables = {
      # You can add SYSTEMD_PAGER here if you want to uncomment it
      # SYSTEMD_PAGER = "";
    };

    # Inject the rest of your .bashrc
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

      # Kitty - fix SSH (see shellAliases for function version)
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
      PS1='[\t \[\e[01;34m\]\u\[\e[0m\]@\[\e[01;34m\]\h\[\e[0m\] \W]\\$ '

      # Set tmux auto attach (when SSH and not already in tmux)
      if [[ -n "$PS1" ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_CONNECTION" ]]; then
        tmux attach-session -t XMR || tmux new-session -s XMR
      fi

      # Fastfetch
      fastfetch
    '';
  };

  #TMUX Setting
  programs.tmux = {
    enable = true;
    extraConfig = ''
      # Send prefix
      set-option -g prefix C-a
      unbind-key C-a
      bind-key C-a send-prefix

      # Use Alt-arrow keys to switch panes
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Shift arrow to switch windows
      bind -n S-Left previous-window
      bind -n S-Right next-window

      # Mouse mode
      setw -g mouse on

      # Set Status bar color
      set-option -g status-style bg=blue

      # Set easier window split keys
      bind-key v split-window -h
      bind-key h split-window -v

      # Easy config reload
      bind-key r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded."
    '';
  };  

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/cyfraka/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
