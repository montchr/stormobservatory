{
  perSystem =
    { config, pkgs, ... }:
    {
      pre-commit.settings = {
        hooks = {
          markdownlint.enable = true;
          markdownlint.excludes = [
            # Auto-generated
            "CHANGELOG.md"
          ];
          treefmt.enable = true;
          yamllint.enable = true;
        };
        default_stages = [
          "pre-commit"
          "pre-push"
        ];

        excludes = [ ];
      };
    };
}
