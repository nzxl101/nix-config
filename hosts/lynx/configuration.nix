{ pkgs, stateVersion, hostname, user, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
  ];
  networking.hostName = hostname;
  system.stateVersion = stateVersion;

  # Static IP configuration
  # networking.interfaces.eth0.ipv4.addresses = [{
  #   address = "192.168.178.101";
  #   prefixLength = 24;
  # }];
  # networking.defaultGateway = "192.168.178.1";
  # networking.nameservers = [ "192.168.178.1" ];
  networking.firewall.allowedTCPPorts = [ 22 ];

  # SSH
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = [ "nzxl" ];
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };
}
