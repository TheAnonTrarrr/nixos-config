{ pkgs, ...}: {
  services.pipewire = {
    enable = true;
    extraConfig.pipewire = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 2048;
        "default.clock.min-quantum" = 1024;
        "default.clock.max-quantum" = 8192;
      };
    };
    pulse.enable = true;
    wireplumber.extraConfig = {   # / Buzz fix - Part 1 / 
        "10-disable-suspend" = {
          "monitor.alsa.rules" = [
            {
              matches = [
                {
                  "node.name" = "~alsa_.*";
                }
              ];
              actions = {
                "update-props" = {
                  "session.suspend-timeout-seconds" = 0;
                };
              };
            }
          ];
        };
    };
  };

  # / Buzz fix - Part 2 /
  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=0
    options snd_hda_intel power_save_controller=N
  '';
}
