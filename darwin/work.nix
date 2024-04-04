{
  config,
  pkgs,
  darwinVars,
  legacy,
  ...
}: let
  hostVars = {
    inherit (darwinVars) editor user;
  };
  omp = import ./shared/oh-my-posh.nix;
in {
  imports = import ./modules;

  nixpkgs.config.allowUnfree = true;
  services = {nix-daemon.enable = true;}; # Auto-Upgrade Daemon

  environment = {
    shells = with pkgs; [zsh]; # Default Shell
    variables = {
      # Environment Variables
      EDITOR = "${hostVars.editor}";
      VISUAL = "${hostVars.editor}";
    };
    systemPackages = [
      # System-Wide Packages
      pkgs.alejandra
      pkgs.awscli2
      legacy.fnm
    ];
  };

  vscode = {
    enable = true;
    osUser = hostVars.user;
    additionalPlugins = with legacy.vscode-extensions; [
      ms-python.python
      redhat.vscode-yaml
      mechatroner.rainbow-csv
      # charliermarsh.ruff
    ];
  };

  users.users.${hostVars.user} = with hostVars; {
    # MacOS User
    name = user;
    home = "/Users/${user}";
    shell = pkgs.zsh; # Default Shell
  };

  git = {
    enable = true;
    osUser = hostVars.user;
    userName = "ChronoSerrano";
    userEmail = "117208915+ChewAli@users.noreply.github.com";
  };

  aws = {
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
        segments = with omp.segments; [os session git aws];
      }
      {
        alignment = "right";
        type = "prompt";
        segments = with omp.segments; [node python battery time];
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

  homebrew = {
    # Homebrew Package Manager
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      # cleanup = "zap";
    };
    brews = [];
    casks = [
      "alacritty"
    ];
    masApps = {
    };
    taps = [
    ];
  };

  zplug = {
    enable = true;
    osUser = hostVars.user;
    plugins = {};
  };

  nix = {
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  python = {
    enable = true;
    osUser = hostVars.user;
  };

  tmux = {
    enable = true;
    osUser = hostVars.user;
    zplug = true;
  };

  home-manager.users.${hostVars.user} = {pkgs, ...}: {
    home = {
      packages = with pkgs; [];
      stateVersion = "23.05";
      sessionVariables = {
        EDITOR = hostVars.editor;
        PATH = "$HOME/.nix-profile/bin:/run/current-system/sw/bin/:$HOME/.config/zsh/scripts:/opt/homebrew/bin:$PATH";
        GRANTED_ALIAS_CONFIGURED = "true";
      };
      file.".config/zsh/scripts/aws_pip".source = ../scripts/aws_pip; # @TODO: move to aws.nix
    };
    xdg = {enable = true;};

    programs = {
      ssh = {
        enable = true;
        matchBlocks = {
          "*" = {
            forwardAgent = false;
            compression = false;
            # host = "*";
            serverAliveCountMax = 3;
            serverAliveInterval = 0;
            # hashKnownHosts = false;
            # userKnownHostsFile = "~/.ssh/known_hosts";
          };
        };
      };

      # HashKnownHosts no
      # UserKnownHostsFile ~/.ssh/known_hosts
      # ControlMaster no
      # ControlPath ~/.ssh/master-%r@%n:%p
      # ControlPersist no
      fzf = {
        enable = true;
        enableZshIntegration = true;
      };
      neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
      };
      zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        dotDir = ".config/zsh";
        #     enableFzfCompletion = true;
        #     enableFzfHistory = true;
        #     enableSyntaxHighlighting = true;

        envExtra = ''
          alias assume="source assume"
          source ~/.config/zsh/scripts/aws_pip
        ''; # @TODO: move aws_pip to aws.nix
        initExtra = " eval \"$(fnm env --use-on-cd)\" ";

        history = {
          expireDuplicatesFirst = true;
          extended = true;
          #        ignoreAllDups = true;
          ignoreSpace = true;
          save = 5000;
          size = 1000000000;
        };
      };
    };
  };
}
