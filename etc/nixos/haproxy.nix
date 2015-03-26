{ config, pkgs, ... }:

{
#  packageOverrides = pkgs: rec {
#    haproxy = pkgs.stdenv.lib.overrideDerivation pkgs.haproxy (oldAttrs : {
#      buildInputs = [ pkgs.openssl ];
#      preConfigure = ''
#        export makeFlags="TARGET=linux2628 PREFIX=$out USE_OPENSSL=yes"
#      '';      
#    });
#  };

  services.haproxy.enable = true;
  services.haproxy.config = ''
    global  
        maxconn 4096  
#        user http
#        group http
        daemon  
    
    defaults  
        log   global  
        mode   http  
        option   httplog  
        option   dontlognull  
        retries   3  
        option redispatch  
        maxconn   2000  
        timeout connect  5000  
        timeout client  50000  
        timeout server  50000  
        log        127.0.0.1       local0  
        log        127.0.0.1       local7 debug  
        option httpchk  
        stats enable  
        stats realm Haproxy\ Statistics  
        stats uri /hpstats
    
    frontend http  
        bind 0.0.0.0:80  
        redirect scheme https if { hdr(host) -i dlg.fuspr.net } !{ ssl_fc }
        redirect scheme https if { hdr(host) -i fbr.fuspr.net }
        redirect scheme https if { hdr(host) -i scrt.fuspr.net }
        redirect scheme https if { hdr(host) -i znc.fuspr.net }
        redirect scheme https if { hdr(host) -i hydra.fuspr.net }
        redirect scheme https if { hdr(host) -i www.fuspr.net }
        redirect scheme https if { hdr(host) -i fuspr.net }
        acl is_dmd hdr_end(host) -i downloadmoredimensions.tk
        acl is_sts hdr_end(host) -i sts.fuspr.net
        use_backend dmd  if is_dmd
        use_backend sts  if is_sts
        default_backend www
    
    frontend https
        bind 0.0.0.0:443 ssl crt /etc/nixos/secret/haproxy.pem npn spdy/2 no-tls-tickets no-sslv3 ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES128-SHA:AES256-SHA256:AES256-SHA
        acl is_www  hdr_end(host) -i www.fuspr.net
        acl is_fbr  hdr_end(host) -i fbr.fuspr.net
        acl is_scrt hdr_end(host) -i scrt.fuspr.net
        acl is_dlg  hdr_end(host) -i dlg.fuspr.net
        acl is_hyd  hdr_end(host) -i hydra.fuspr.net
        acl is_znc  hdr_end(host) -i znc.fuspr.net
        use_backend www  if is_www
        use_backend fbr  if is_fbr
        use_backend scrt if is_scrt
        use_backend dlg  if is_dlg
        use_backend hyd  if is_hyd
        use_backend znc  if is_znc
        default_backend www
    
    backend www
        server www 127.0.0.1:8000
    backend fbr
        server fbr 127.0.0.1:8001
    backend dmd
        server fbr 127.0.0.1:5432
    backend sts
        server sts 127.0.0.1:3000
    backend scrt
        server scrt 127.0.0.1:8002
    backend dlg
        server dlg 127.0.0.1:8112
    backend hyd
        server hyd 127.0.0.1:5566
    backend znc
        server znc 127.0.0.1:6643
  '';
}

