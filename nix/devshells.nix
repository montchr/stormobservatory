{
  perSystem =
    {
      config,
      inputs',
      pkgs,
      ...
    }:
    let
      commonPkgs = [
        pkgs.biome
        pkgs.fd
        pkgs.gnused
        pkgs.jq
        pkgs.just
        pkgs.moreutils # provides `sponge`
        pkgs.ripgrep
        pkgs.rsync
      ];
    in
    {
      devShells.default = pkgs.mkShellNoCC {
        shellHook = ''
          : "''${PRJ_BIN_HOME:=''${PRJ_PATH:-''${PRJ_ROOT}/.bin}}"

          export PRJ_BIN_HOME

          ${config.pre-commit.installationScript}
        '';
        nativeBuildInputs = commonPkgs ++ [
          pkgs.recyclarr
          config.pre-commit.settings.hooks.markdownlint.package
          config.pre-commit.settings.hooks.yamllint.package

          pkgs.dos2unix
          pkgs.nixfmt # pkgs.nixfmt-rfc-style via overlay
          pkgs.nodePackages.prettier
          pkgs.taplo
          pkgs.treefmt # pkgs.treefmt2 via overlay

          # pre-commit helper tool to simplify file matching.  For example,
          # the `yml` and `yaml` extensions share the same "type" of `yaml`.
          # Otherwise, you would need to write a regexp for both extensions.
          # <https://pre-commit.com/#filtering-files-with-types>
          # NOTE: The command is `identify-cli`, not to be confused with
          # imagemagick's `identify`.
          pkgs.python311Packages.identify
        ];
      };
    };
}
