{
  programs.git = {
    enable = true;
    userName = "nzxl101";
    userEmail = "nzxl@nzxl.space";
    extraConfig = {
      credential = {
        helper = "manager";
        "https://github.com".username = "nzxl101";
        credentialStore = "cache";
      };
    };
  };
}