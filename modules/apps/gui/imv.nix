{
  flake.homeModules.kybe = { basenix, ... }: {
    programs.imv = {
      enable = true;
      settings.options = {
        background = basenix.colors.base00;
        overlay_text_color = basenix.colors.base05;
      };
    };
  };
}
