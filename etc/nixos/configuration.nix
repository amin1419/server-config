{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix
      ./passwords.nix
      ./users.nix
      ./system.nix
    ];
}
