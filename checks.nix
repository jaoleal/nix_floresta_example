# This nix expression just load the statix and nixfmt-rfc-style checks from git-hooks.nix
{
  link ? "https://github.com/cachix/git-hooks.nix/tarball/master",
}:
let
  gitHooks = import (builtins.fetchTarball link);
in
gitHooks.run {
  src = ./.;
  hooks = {
    nixfmt-rfc-syle.enable = true;
    statix.enable = true;
  };
}
