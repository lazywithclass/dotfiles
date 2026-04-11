{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-anki.url = "github:nixos/nixpkgs/87848bf0cc4f87717fc813a4575f07330c3e743c";
    claude-desktop.url = "github:aaddrick/claude-desktop-debian";
    claude-code-nix.url = "github:sadjow/claude-code-nix";
  };

  outputs = { nixpkgs, nixpkgs-anki, home-manager, claude-desktop, claude-code-nix, ... }: {
    homeConfigurations."lazywithclass" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = { 
        inherit claude-desktop claude-code-nix;
        pkgsAnki = nixpkgs-anki.legacyPackages.x86_64-linux;
      };
      modules = [ ./home.nix ];
    };
  };
}
