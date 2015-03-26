{ config, pkgs, ... }:

{
  imports = [
    ./containers/fuspr-ts3.nix
    ./containers/fuspr-web.nix
  ];
}
