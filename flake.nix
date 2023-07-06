{
  description = "Nix flake for mtg edition chooser";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    }:

    flake-utils.lib.eachDefaultSystem (system:
    let
      overlays = [
        (self: super: rec {
        })
      ];
      pkgs = import nixpkgs { inherit overlays system; };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [  pkgs.nodejs-18_x pkgs.playwright-driver ];

        PLAYWRIGHT_BROWSERS_PATH="${pkgs.playwright-driver.browsers}";

        shellHook = ''
          echo "Ready to blog"
        '';
      };
    });
}

