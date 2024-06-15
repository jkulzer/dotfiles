{ config, pkgs, inputs, ... }:

  let
    lock-false = {
      Value = false;
      Status = "locked";
    };
    lock-true = {
      Value = true;
      Status = "locked";
    };
  in
{
	stylix.targets.firefox = {
		enable = true;
		profileNames = [ "johannes" ];
	};
  programs.firefox = {
		enable = true;
		profiles.johannes = {
			extensions = with pkgs.nur.repos.rycee.firefox-addons; [ 
				ublock-origin 
				bitwarden 
				enhancer-for-youtube
				facebook-container
				fastforwardteam
				reddit-enhancement-suite
				sponsorblock
				tab-counter-plus
				tree-style-tab
				multi-account-containers
			];
			userChrome = ''
/* hides the native tabs */
#TabsToolbar {
  display: none;
}
		'';

			search = {
				default = "DuckDuckGo";
				force = true;
			};
		};
		

		/* ---- POLICIES ---- */
		# Check about:policies#documentation for options.
		policies = {
			DisableTelemetry = true;
			DisableFirefoxStudies = true;
			EnableTrackingProtection = {
				Value= true;
				Locked = true;
				Cryptomining = true;
				Fingerprinting = true;
			};
			Extensions = {
				Install = [
					"https://addons.mozilla.org/firefox/downloads/latest/youtube-mrbeastify/latest.xpi"
					"https://addons.mozilla.org/firefox/downloads/latest/xkit-rewritten/latest.xpi"
					"https://addons.mozilla.org/firefox/downloads/latest/shinigami-eyes/latest.xpi"
				];
			};
			NewTabPage = false;
			DisablePocket = true;
			DisableFirefoxScreenshots = true;
			OverrideFirstRunPage = "";
			OverridePostUpdatePage = "";
			DontCheckDefaultBrowser = true;
			DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
			DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
			SearchBar = "unified"; # alternative: "separate"

			/* ---- EXTENSIONS ---- */
			# Check about:support for extension/add-on ID strings.
			# Valid strings for installation_mode are "allowed", "blocked",
			# "force_installed" and "normal_installed".
			/* ---- PREFERENCES ---- */
			# Check about:config for options.
			Preferences = { 
				"browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
				"extensions.pocket.enabled" = lock-false;
				"extensions.screenshots.disabled" = lock-true;
				"browser.topsites.contile.enabled" = lock-false;
				"browser.formfill.enable" = lock-false;
				"browser.search.suggest.enabled" = lock-false;
				"browser.search.suggest.enabled.private" = lock-false;
				"browser.urlbar.suggest.searches" = lock-false;
				"browser.urlbar.showSearchSuggestionsFirst" = lock-false;
				"browser.newtabpage.activity-stream.default.sites" = { Value = "none"; };
				"browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
				"browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
				"browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
				"browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
				"browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
				"browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
				"browser.newtabpage.activity-stream.showSponsored" = lock-false;
				"browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
				"browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
				"browser.startup.page" = { Value = 3; Status = "locked";};
				"browser.ctrlTab.sortByRecentlyUsed" = lock-true;
			};
		};
  };
}
