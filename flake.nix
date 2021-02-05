{
  description = "purescript-kagome";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    devShell.x86_64-linux =
      with nixpkgs.legacyPackages.x86_64-linux;

      mkShell {
        name = "purescript-kagome-dev";

        nativeBuildInputs = [
          purescript spago
        ];
      };
  };
}
