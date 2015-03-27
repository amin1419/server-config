{ config, pkgs, ... }:

{
  imports = [];

  security.grsecurity.enable = true;
  security.grsecurity.testing = true;
  security.grsecurity.system = "server";
  security.grsecurity.hardwareVirtualisation = true;
}
