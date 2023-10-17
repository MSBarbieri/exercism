{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs =
    { self
    , nixpkgs
    , utils
    , pre-commit-hooks
    , ...
    }:
    utils.lib.eachDefaultSystem
      (system:
      let
        inherit (pkgs.lib) optional optionals;
        pkgs = import nixpkgs
          {
            inherit system;
            config = {
              permittedInsecurePackages = [
                "nodejs-14.21.3"
                "nodejs-16.20.2"
                "openssl-1.1.1w"
              ];
            };
          };

        elixir = pkgs.beam.packages.erlang.elixir;
      in
      {
        checks = {
          pre-commit-check = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              nixpkgs-fmt.enable = true;
            };
          };
        };

        devShells.default = pkgs.mkShellNoCC {
          shellHook = ''
          '' + (self.checks.${system}.pre-commit-check).shellHook;

          impure = true;
          buildInputs = with pkgs; [
            elixir
            elixir_ls
            glibcLocales
          ] ++ optional stdenv.isLinux inotify-tools
          ++ optional stdenv.isDarwin terminal-notifier
          ++ optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
            CoreFoundation
            CoreServices
          ]);

          nativeBuildInputs = [ pkgs.pkg-config ];
        };
      });
}
