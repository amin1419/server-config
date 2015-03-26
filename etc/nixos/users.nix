{ config, pkgs, ... }:

{
  programs.zsh.enable = true;

  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

  users.extraUsers.remy = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    description = "Remy Goldschmidt";
    uid = 1000;
  };

  users.extraUsers.guest = {
    isNormalUser = true;
    uid = 1001;
  };

  environment.shellInit = "export NIXPKGS=/home/remy/nixpkgs/";

  environment.shellAliases = {
    ls = "ls --color=auto -FX";
    l = "ls";
    sl = "ls";
    lh = "ls -lAh";
    ll = "ls -lAv --group-directories-first";
  
    mkdir = "mkdir -p";
  
    du = "du -kh";
    df = "df -kTh";
  
    rem = "rm";
    del = "rm";
    quit = "exit";
  
    edit = "emacs";
    vi = "emacs";
    vim = "emacs";
    sedit = "sudo emacs";
    semc = "sudo emacs";
    svim = "sudo emacs";
    svi = "sudo emacs";
    suno = "sudo emacs";
  
    sc = "systemctl";
    sd = "sudo systemctl";
    ss = "systemctl --user";
    jc = "journalctl";
    jd = "sudo journalctl";
    mc = "machinectl";
    md = "sudo machinectl";
      
    g = "git";
    gad = "git add";
    grm = "git rm";
    gmv = "git mv";
    gps = "git push";
    gst = "git status";
    gdf = "git diff";

    nxr = "nixos-rebuild -I nixos=$NIXPKGS/nixos -I nixpkgs=$NIXPKGS ";
  };

  users.mutableUsers = false;
}
