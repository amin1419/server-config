{ config, pkgs, ... }:

{
  imports =
    [ ./boot.nix
      ./locale.nix
    ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    git
    file
    emacs
  ];

  networking.hostName = "REMYSERVER";

  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];
  networking.firewall.allowPing = true;

  networking.nat.enable = true;
  networking.nat.internalInterfaces = ["ve-+"];
  networking.nat.externalInterface = "eth0";

  services.openssh.enable = true;

  services.kmscon.enable = true;
  services.kmscon.extraConfig = "font-size=14";

  services.nixosManual.showManual = true;
}
