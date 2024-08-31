{
  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    flake-parts = { url = "github:hercules-ci/flake-parts"; };
  };

  outputs = { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      perSystem = { pkgs, config, ... }: {
        devShells = {
          default = pkgs.mkShell {
            packages = with pkgs; [ # #
              nixfmt-classic
              nixd
              qmk
            ];

            shellHook = ''
              export QMK_HOME=$(pwd)

              qmk config user.keyboard=zsa/moonlander
              qmk config user.keymap=miryoku-colemak-dh
            '';
          };
        };
      };
    };
}
