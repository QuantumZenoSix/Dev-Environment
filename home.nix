{ config, pkgs, lib, inputs, ... }:
# ^ note: we added inputs here via extraSpecialArgs in the flake → gives access to flake inputs

{
    # ────────────────────────────────────────────────────────────────
    #  Identity & State
    # ────────────────────────────────────────────────────────────────
    home.username      = "zeno";                    # ← change this
    home.homeDirectory = "/home/zeno";
    home.stateVersion  = "25.05";                    # ← use current or newer stable version
                                                   #    NEVER change this value after first activation!

    # ────────────────────────────────────────────────────────────────
    #  Packages installed into user profile (~/.nix-profile)
    # ────────────────────────────────────────────────────────────────
    home.packages = with pkgs; [
        # CLI & tools almost everyone wants
        helix               # lightweight modal editor alternative
        killall            # convenience

        # Dev tools (add what you use)
        # just               # better make alternative
        # direnv nix-direnv  # auto-load .envrc / dev shells
        # gitui lazygit      # TUIs for git

    ];

    # ────────────────────────────────────────────────────────────────
    #  Fonts – the modern / recommended way
    # ────────────────────────────────────────────────────────────────
      fonts.fontconfig.enable = true;

    # If you want nerd fonts, jetbrains, etc.
    home.packages = with pkgs; [
        (nerd-fonts.override { fonts = [ "JetBrainsMono" "FiraCode" "Hack" ]; })
    ];

    # ────────────────────────────────────────────────────────────────
    #  Programs – declarative configuration of popular software
    # ────────────────────────────────────────────────────────────────
    programs = {

        home-manager.enable = true;   # required – lets home-manager manage itself

        history = {
            size = 20000;
            path = "${config.xdg.dataHome}/zsh/history";
        };

        direnv = {
            enable = true;
            enableZshIntegration = true;
            nix-direnv.enable = true;   # much faster than vanilla direnv + nix
        };

        bat.enable = true;
        eza.enable = true;
        eza.enableZshIntegration = true;
        eza.icons = true;
        eza.git = true;

        # neovim = {
        #             enable = true;
        #     defaultEditor = true;          # EDITOR=nvim
        #         viAlias = true;
        #     vimAlias = true;
        # # If you use nixvim → remove this block and import nixvim module instead
        # };
        #
        # fzf = {
        #     enable = true;
        #     enableZshIntegration = true;
        #     defaultCommand = "fd --type f --hidden --exclude .git";
        #     defaultOptions = [ "--height 50%" "--layout=reverse" "--border" ];
        # };

        # git = {
        #   enable = true;
        #   userName  = "XXX";
        #   userEmail = "XXX";   # ← use your real email
        #   ignores   = [ "*.swp" "*.swo" ".DS_Store" ];
        #   extraConfig = {
        #     init.defaultBranch = "main";
        #     core.editor        = "nvim";
        #     pager              = "delta";        # pretty diff pager
        #     pull.rebase        = true;
        #   };
        #   delta = {
        #     enable = true;
        #     options = {
        #       side-by-side = true;
        #       line-numbers = true;
        #     };
        #   };
        # };
        #

        # zsh = {
        #   enable = true;
        #   autocd = true;
        #   autosuggestion.enable = true;
        #   syntaxHighlighting.enable = true;
        #
        #   shellAliases = {
        #     ll     = "eza -la --icons --git";
        #     ls     = "eza --icons";
        #     cat    = "bat";
        #     gs     = "git status";
        #     gc     = "git commit";
        #     gp     = "git push";
        #     gco    = "git checkout";
        #     update = "home-manager switch --flake ~/nix-config#bobby";
        #     rebuild = "update";
        #     flake-check = "nix flake check ~/nix-config";
        #   };
        #
        #   oh-my-zsh = {
        #     enable = true;
        #     theme = "agnoster";          # ← very popular, clean alternative to robbyrussell
        #     plugins = [ "git" "docker" "docker-compose" "z" "fzf" ];
        #   };
        #
        #   If you prefer pure zsh without oh-my-zsh → comment oh-my-zsh and use zsh plugins instead
        #   zplug or zinit can also be used via programs.zsh.plugins
        # };

         # Modern alternative to zsh + oh-my-zsh (many people switch to this in 2025+)
         # fish = {
         #   enable = true;
         #   interactiveShellInit = ''
         #     set fish_greeting ""
         #     starship init fish | source
         #   '';
         #   plugins = [
         #     { name = "z"; src = pkgs.fishPlugins.z.src; }
         #     { name = "fzf"; src = pkgs.fishPlugins.fzf-fish.src; }
         #   ];
         # };
         #
         # # Very popular – fast & beautiful prompt
         # starship = {
         #   enable = true;
         #   enableZshIntegration = true;
         #   # enableFishIntegration = true; (if you use fish)
         #   settings = {
         #     # You can customize here or use ~/.config/starship.toml
         #     add_newline = false;
         #     line_break.disabled = false;
         #   };
         # };
         #
         #
         # # If you use helix → nice lightweight alternative to neovim
         # helix = { enable = true; };
         #
         # If you use tmux
         # tmux = {
         #   enable = true;
         #   clock24 = true;
         #   mouse = true;
         #   terminal = "tmux-256color";
         #   extraConfig = ''
         #     set -g @plugin 'tmux-plugins/tpm'
         #     # ... more plugins
         #   '';
         # };


    # END Programs
    };


    # ────────────────────────────────────────────────────────────────
    #  Session variables (exported to shell)
    # ────────────────────────────────────────────────────────────────
    home.sessionVariables = {
    EDITOR     = "nvim";
    VISUAL     = "nvim";
    MANPAGER   = "sh -c 'col -bx | bat -l man -p'";
    BAT_THEME  = "catppuccin-mocha";
    # Add any other env vars you need globally
    };

    # ────────────────────────────────────────────────────────────────
    #  XDG user directories (optional but clean)
    # ────────────────────────────────────────────────────────────────
    xdg = {
        enable = true;
        userDirs = {
            enable = true;
            createDirectories = true;
        };
    };


    # ────────────────────────────────────────────────────────────────
    #  Manual dotfile symlinking (alternative / legacy style)
    # ────────────────────────────────────────────────────────────────

    home.file = {
      # single files in $HOME
      ".bashrc".source               = ./config/.bashrc;
      ".zshrc".source                = ./config/.zshrc;
      ".zsh_customizations".source   = ./config/.zsh_customizations;
      ".p10k.zsh".source             = ./config/.p10k.zsh;
      ".bash_aliases".source         = ./config/.bash_aliases;
      ".bash_git".source             = ./config/.bash_git;
      ".bash_pbx".source             = ./config/.bash_pbx;    
      ".bash_utils".source           = ./config/.bash_utils;
      ".tmux.conf".source            = ./config/.tmux.conf;
      ".tmux_init.sh".source         = ./config/.tmux_init.sh;
      ".vimrc".source                = ./config/.vimrc;
      ".wezterm.lua".source          = ./config/.wezterm.lua;   
      # ".config/starship.toml".source = ./config/starship.toml;   # ← no leading .config/

      # ───────────────────────────────────────────────
      # Folders: programs inside ~/.config/<program>/
      ".config/lazygit".source       = ./config/.config/lazygit;
      ".config/nvim".source          = ./config/.config/nvim;
      ".config/yazi".source          = ./config/.config/yazi;
      ".config/spotify-player".source = ./config/.config/spotify-player;

        # sudo cp -v -f -r ./config/usr_local_bin/* /usr/local/bin/
    };


    # ────────────────────────────────────────────────────────────────
    #  Nicely reloads system units when changing things
    # ────────────────────────────────────────────────────────────────
    systemd.user.startServices = "sd-switch";

    # Optional: let Home Manager install and manage itself
    # programs.home-manager.enable = true;
}
