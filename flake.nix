{
  description = "Nix flake for mtg edition chooser";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23de9f3b56e72632c628d92b71c47032e14a3d4d";
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
        packages = with pkgs; [  pkgs.nodejs-18_x pkgs.playwright-test ];

        PLAYWRIGHT_BROWSERS_PATH="${pkgs.playwright-driver.browsers}";

        shellHook = ''
          # Remove playwright from node_modules, so it will be taken from playwright-test
          rm node_modules/@playwright/ -R
          echo "Ready to blog"
        '';
      };
    });
}

