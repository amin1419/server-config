{ config, pkgs, ... }:

{
  imports = [];

  security.grsecurity.enable = true;
  security.grsecurity.testing = true;
  security.grsecurity.config.system = "server";
  security.grsecurity.config.hardwareVirtualisation = true;
}
