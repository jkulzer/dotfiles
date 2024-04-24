{ lib, config, ...}:
{
  config = lib.mkIf config.jkulzerFlakeLib.graphicalSystem.enable {
		environment.extraInit = ''
		if [ "$XDG_SESSION_DESKTOP" = "sway" ] ; then
  	  # https://github.com/swaywm/sway/issues/595
  	  export _JAVA_AWT_WM_NONREPARENTING=1
		fi
		'';
	};
}
