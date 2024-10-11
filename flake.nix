{
  description = "w1png Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager }:
  let
    configuration = { pkgs, config, ... }: {
      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.allowUnsupportedSystem = true;

      fonts.packages = with pkgs; [
        fira-code
        fira-code-symbols
        geist-font
        nerdfonts
      ];

      environment.systemPackages =
        [ 
            # CLI apps
            pkgs.neovim
            pkgs.tmux
            pkgs.htop
            pkgs.neofetch

            # Programming languages
            pkgs.nodejs_22
            pkgs.go
            pkgs.bun
            pkgs.python313

            # GUI apps
            pkgs.discord
            pkgs.qbittorrent
            pkgs.raycast
            pkgs.arc-browser

            # Terminal utils
            pkgs.httpie
            pkgs.zoxide
            pkgs.jq
            pkgs.wget
            pkgs.fzf
            pkgs.gcc
            pkgs.fx
            pkgs.eza
            pkgs.fd
            pkgs.bat
            pkgs.duf
            pkgs.ripgrep

            # Misc
            pkgs.mkalias
        ];

        homebrew = {
          enable = true;
          casks = [
            "wezterm"
            "the-unarchiver"
            "nikitabobko/tap/aerospace"
            "prismlauncher"
            "orbstack"
          ];
          onActivation.cleanup = "zap";
          masApps = {
            "Telegram" = 747648890;
            "WhatsApp" = 310633997;
            "Wireguard" = 1451685025;
         };
        };

        system.defaults = {
          dock.autohide = true;
          finder.AppleShowAllExtensions = true;
          finder.FXPreferredViewStyle = "clmv";
          loginwindow.GuestEnabled  = false;
          NSGlobalDomain.AppleInterfaceStyle = "Dark";
        };

        # Symlink applications to /Applications/Nix
        system.activationScripts.applications.text = let
          env = pkgs.buildEnv {
            name = "system-applications";
            paths = config.environment.systemPackages;
            pathsToLink = "/Applications";
          };
        in
          pkgs.lib.mkForce ''
          # Set up applications.
          echo "setting up /Applications..." >&2
          rm -rf /Applications/Nix\ Apps
          mkdir -p /Applications/Nix\ Apps
          find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
        '';

      services.nix-daemon.enable = true;
      nix.settings.experimental-features = "nix-command flakes";
      programs.zsh.enable = true;
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;

      users.users.w1png.home = "/Users/w1png";
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#MacBookPro
    darwinConfigurations."MacBookPro" = nix-darwin.lib.darwinSystem {
      modules = [ 
          configuration
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.w1png = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
          nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "w1png";
            autoMigrate = true;
          };
        }
      ];
    };
    darwinPackages = self.darwinConfigurations."MacBookPro".pkgs;
  };
}
