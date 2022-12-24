{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }: {
    overlays.default = final: prev: {
      multi-git-status = final.callPackage ./mgitstatus.nix { };
    };
  } // flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          self.overlays.default
        ];
      };
    in
      {
        packages = {
          inherit (pkgs) multi-git-status;
          default = pkgs.multi-git-status;
        };
      }
  );
}
