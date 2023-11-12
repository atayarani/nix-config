#
#  Specific system configuration settings for MacBook
#
#  flake.nix
#   └─ ./darwin
#       ├─ default.nix
#       ├─ personal.nix *
#       ├─ work.nix
#       └─ ./modules
#           └─ default.nix
#
{
  config,
  pkgs,
  legacy,
  lib,
  darwinVars,
  ...
}: let
  hostVars = {
    inherit (darwinVars) editor;
    user = "alitayarani";
  };
  omp = import ./shared/oh-my-posh.nix;
  xdg_data_dir = "/Users/alitayarani/.local/share";
in {
  imports = import ./modules;
  nixpkgs.config.allowUnfree = true;

  git = {
    enable = true;
    osUser = hostVars.user;
    userName = "ChronoSerrano";
    userEmail = "619512+ChronoSerrano@users.noreply.github.com";
  };

  vscode = {
    enable = true;
    osUser = hostVars.user;
  };

  zplug = {
    enable = true;
    osUser = hostVars.user;
    plugins = {
      fnm = true;
    };
  };

  zsh = {
    enable = true;
    osUser = hostVars.user;
  };

  oh-my-posh = {
    enable = true;
    osUser = hostVars.user;
    blocks = [
      {
        alignment = "left";
        type = "prompt";
        segments = with omp.segments; [os session git];
      }
      {
        alignment = "right";
        type = "prompt";
        segments = with omp.segments; [battery time];
      }
      {
        alignment = "left";
        type = "prompt";
        newline = true;
        segments = with omp.segments; [path];
      }
      omp.segments.status
    ];
  };

  # espanso = {
  #   enable = true;
  #   osUser = hostVars.user;
  #   config = {search_shortcut = "CTRL+SPACE";};
  # };

  tmux = {
    enable = true;
    osUser = hostVars.user;
  };

  users.users.${hostVars.user} = with hostVars; {
    # MacOS User
    name = user;
    home = "/Users/${user}";
    shell = pkgs.zsh; # Default Shell
  };

  environment = {
    shells = with pkgs; [zsh]; # Default Shell
    variables = {};
    systemPackages = [
      # System-Wide Packages
      pkgs.alejandra
      legacy.fnm
      legacy.chezmoi
      legacy.pre-commit
    ];
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "FiraCode"
        ];
      })
    ];
  };

  nix = {
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  services = {nix-daemon = {enable = true;};};

  homebrew = {
    # Homebrew Package Manager
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };
    brews = [];
    casks = [
      "1password-beta"
      "alacritty"
      "alfred"
      "authy"
      "caffeine"
      "flux"
      "handbrake"
      "itch"
      "iterm2"
      "macupdater"
      "obsidian"
      "openaudible"
      "setapp"
      "sonos"
      "steam"
      "tailscale"
      "zoom"
      "zotero"
    ];
    masApps = {
      Infuse = 1136220934;
      LanScan = 472226235;
    };
    taps = [
      "homebrew/cask-versions"
    ];
  };

  gh = {
    inherit (hostVars) user editor;
    enable = true;
  };

  nvim = {
    enable = true;
    osUser = hostVars.user;
  };

  home-manager.users.${hostVars.user} = {
    home = {
      sessionVariables = {
        PATH = "$HOME/.nix-profile/bin:/run/current-system/sw/bin/:$HOME/.config/zsh/scripts:/opt/homebrew/bin:$PATH";
        XDG_RUNTIME_DIR = "/run/user/$UID";
      };
      stateVersion = "23.05";
      shellAliases = {
        xdg-ninja = "nix run github:b3nj5m1n/xdg-ninja";
        wget = "wget --hsts-file=\"$XDG_DATA_HOME/wget-hsts\"";
      };
      packages = with pkgs; [];
    };

    programs = {
      alacritty = {
        enable = true;
        settings = {};
      };
      fzf = {
        enable = true;
        enableZshIntegration = true;
      };
      go = {
        enable = true;
        goPath = ".local/share/go"; # @TODO: There should be an xdg var here
      };
      gpg = {
        enable = true;
        homedir = "${xdg_data_dir}/gnupg"; # @TODO: There should be an xdg var here
        mutableKeys = false;
        mutableTrust = false;
      };
      jq.enable = true;
      pandoc.enable = true;
      ssh.enable = true;
      tealdeer.enable = true;
      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
    };

    xdg.enable = true;
  };
}
