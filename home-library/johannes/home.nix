{
	osConfig,
  ...
}: {
  home.username = "${osConfig.jkulzerFlakeLib.userName}";
  home.homeDirectory = "/home/johannes";

  home.stateVersion = "23.11";
  #} # End of User config
}
