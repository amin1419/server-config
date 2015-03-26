{ config, pkgs, ... }:

{
  imports =
    [ ./boot.nix
      ./locale.nix
      ./haproxy.nix
    ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    git
    file
    emacs24-nox
    inconsolata
  ];

  networking.hostName = "REMYSERVER";

  networking.enableIPv6 = false;
  boot.kernelParams = [ "ipv6.disable=1" ];

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 10011 30033 80 443 ];
  networking.firewall.allowedUDPPorts = [ 9987 ];
  networking.firewall.allowPing = true;

  networking.nat.enable = true;
  networking.nat.forwardPorts = [
#    { sourcePort = 9987;  destination = "192.168.101.11:9987"; }
  ];
  networking.nat.internalInterfaces = ["ve-+"];
  networking.nat.externalInterface = "enp4s0";

  services.openssh.permitRootLogin = "no";
  services.openssh.enable = true;
  services.fail2ban.enable = true;
  services.fail2ban.jails.DEFAULT = ''
    ignoreip = 127.0.0.1/8
    bantime = 600
    findtime = 600
    maxretry = 3
    backend = auto
    enabled = true
  '';

  services.kmscon.enable = true;
  services.kmscon.extraConfig = ''
    font-name=Inconsolata
    font-engine=pango
  '';

  services.nixosManual.showManual = true;
}
