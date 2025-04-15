{
  description = "A very basic flake example about consuming the floresta project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    floresta-master.url = "github:vinteumorg/floresta"; # Using the latest nix expressions
    floresta-by-tag.url = "github:vinteumorg/floresta?tag=0.X.0"; # you can specify a tag.
    # *Attention*: The flake and nix expressions inside floresta became stable on 0.8.0
  };

  outputs =
    { self, ... }@inputs:
    let
      # Specify your system, these are the ones we support by now: platforms = [ "aarch64-linux" "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
      system = "x86_64-linux";
      floresta = inputs.floresta-master.packages.${system}.default; # the "default" package will retrieve these components: [ libfloresta, florestad , floresta-cli ]
      florestad = inputs.floresta-master.packages.${system}.florestad;
      floresta-cli = inputs.floresta-master.packages.${system}.floresta-cli;
    in
    {
      devShells.${system}.default = (import inputs.nixpkgs { inherit system; }).mkShell {

        nativeBuildInputs = [
          floresta
          florestad
          floresta-cli
        ];

        shellHook = ''
          echo "floresta @: ${floresta}"
          echo "florestad @: ${florestad}"
          echo "floresta-cli @: ${floresta-cli}"

          echo "Try running it!"
          echo ""
          echo "$ florestad"

          echo "$ floresta-cli getblockchaininfo"
        '';
      };
    };
}
