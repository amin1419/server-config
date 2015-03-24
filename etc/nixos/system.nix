{ config, pkgs, ... }:

{
  imports =
    [ ./boot.nix
      ./locale.nix
    ];

  environment.systemPackages = with pkgs; [
    wget
    git
    file
  ];

  networking.hostName = "REMYSERVER";

  services.openssh.enable = true;
}
