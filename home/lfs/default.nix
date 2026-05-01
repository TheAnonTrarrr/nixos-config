# /////////////////////////
# //                     //
# //    Home-Manager     //
# //                     //
# //      home.nix       //
# //                     //
# /////////////////////////

{ config, pkgs, ... }:

{

  # // Basic Configuration //
  home.username = "lfs";
  home.homeDirectory = "/home/lfs";


  # // Version (DO NOT CHANGE) //
  home.stateVersion = "25.11";

  programs = {
    kitty = {
      enable = true;
      settings = { paste_actions = "no-op"; };
    };
  };

}
