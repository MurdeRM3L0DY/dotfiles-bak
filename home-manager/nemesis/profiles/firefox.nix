{inputs, ...}: {
  lib,
  pkgs,
  config,
  ...
}: {
  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        ublock-origin
        darkreader
      ];
      search = {
        default = "DuckDuckGo";
      };
      settings = {
        # https://github.com/arkenfox/user.js
        # Enable ETP for decent security (makes firefox containers and many
        # common security/privacy add-ons redundant).
        "browser.contentblocking.category" = "strict";
        "privacy.donottrackheader.enabled" = true;
        "privacy.donottrackheader.value" = 1;
        "privacy.purge_trackers.enabled" = true;

        "geo.enabled" = false;

        # Disable telemetry
        # https://wiki.mozilla.org/Platform/Features/Telemetry
        # https://wiki.mozilla.org/Privacy/Reviews/Telemetry
        # https://wiki.mozilla.org/Telemetry
        # https://www.mozilla.org/en-US/legal/privacy/firefox.html#telemetry
        # https://support.mozilla.org/t5/Firefox-crashes/Mozilla-Crash-Reporter/ta-p/1715
        # https://wiki.mozilla.org/Security/Reviews/Firefox6/ReviewNotes/telemetry
        # https://gecko.readthedocs.io/en/latest/browser/experiments/experiments/manifest.html
        # https://wiki.mozilla.org/Telemetry/Experiments
        # https://support.mozilla.org/en-US/questions/1197144
        # https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/telemetry/internals/preferences.html#id1
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";
        "experiments.supported" = false;
        "experiments.enabled" = false;
        "experiments.manifest.uri" = "";
        "browser.ping-centre.telemetry" = false;
        # Don't use the built-in password manager. A nixos user is more likely
        # using an external one (you are using one, right?).
        "signon.rememberSignons" = false;
        # Do not check if Firefox is the default browser
        "browser.shell.checkDefaultBrowser" = false;
        # Disable the "new tab page" feature and show a blank tab instead
        # https://wiki.mozilla.org/Privacy/Reviews/New_Tab
        # https://support.mozilla.org/en-US/kb/new-tab-page-show-hide-and-customize-top-sites#w_how-do-i-turn-the-new-tab-page-off
        "browser.newtabpage.enabled" = false;
        "browser.newtab.url" = "about:blank";
        # Disable Activity Stream
        # https://wiki.mozilla.org/Firefox/Activity_Stream
        "browser.newtabpage.activity-stream.enabled" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;

        "browser.privatebrowsing.autostart" = true;

        "startup.welcome.url" = "about:blank";
        "browser.startup.homepage" = "about:blank";
        "app.feedback.baseURL" = "about:blank";
        "app.update.auto" = false;
        "app.update.background.scheduling.enabled" = false;
        # Disable new tab tile ads & preload
        # http://www.thewindowsclub.com/disable-remove-ad-tiles-from-firefox
        # http://forums.mozillazine.org/viewtopic.php?p=13876331#p13876331
        # https://wiki.mozilla.org/Tiles/Technical_Documentation#Ping
        # https://gecko.readthedocs.org/en/latest/browser/browser/DirectoryLinksProvider.html#browser-newtabpage-directory-source
        # https://gecko.readthedocs.org/en/latest/browser/browser/DirectoryLinksProvider.html#browser-newtabpage-directory-ping
        "browser.newtabpage.enhanced" = false;
        "browser.newtabpage.introShown" = true;
        "browser.newtab.preload" = false;
        "browser.newtabpage.directory.ping" = "";
        "browser.newtabpage.directory.source" = "data:text/plain,{}";

        "browser.region.network.url" = "";
        "browser.region.update.enabled" = false;

        "intl.accept_languages" = "en-US, en";
        "javascript.use_us_english_locale" = true;
        # https://support.mozilla.org/en-US/kb/extension-recommendations
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "extensions.htmlaboutaddons.discover.enabled" = false;
        "extensions.getAddons.showPane" = false; # uses Google Analytics
        "browser.discovery.enabled" = false;
        # Use Mozilla geolocation service instead of Google if given permission
        "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
        "geo.provider.use_gpsd" = false;
        "geo.provider.use_geoclie" = false;
        # Disable battery API
        # https://developer.mozilla.org/en-US/docs/Web/API/BatteryManager
        # https://bugzilla.mozilla.org/show_bug.cgi?id=1313580
        "dom.battery.enabled" = false;
        # Disable "beacon" asynchronous HTTP transfers (used for analytics)
        # https://developer.mozilla.org/en-US/docs/Web/API/navigator.sendBeacon
        "beacon.enabled" = false;
        # Disable pinging URIs specified in HTML <a> ping= attributes
        # http://kb.mozillazine.org/Browser.send_pings
        "browser.send_pings" = false;
        # https://mozilla.github.io/normandy/
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";
        "app.shield.optoutstudies.enabled" = false;
        # Disable health reports (basically more telemetry)
        # https://support.mozilla.org/en-US/kb/firefox-health-report-understand-your-browser-perf
        # https://gecko.readthedocs.org/en/latest/toolkit/components/telemetry/telemetry/preferences.html
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;

        # Disable crash reports
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false; # don't submit backlogged reports
        # Disable Form autofill
        # https://wiki.mozilla.org/Firefox/Features/Form_Autofill
        "browser.formfill.enable" = false;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.available" = "off";
        "extensions.formautofill.creditCards.available" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "extensions.formautofill.heuristics.enabled" = false;

        # DoH
        "network.trr.mode" = 3;
        "network.trr.url" = "https://dns.mullvad.net/dns-query";
        "network.trr.custom_url" = "https://dns.mullvad.net/dns-query";
        "network.trr.default_provider_uri" = "https://dns.mullvad.net/dns-query";

        "network.captive-portal-service.enabled" = false;

        "network.connectivity-service.enabled" = false;
        "network.connectivity-service.IPv4.url" = "";
        "network.connectivity-service.IPv6.url" = "";

        "network.connectivity-service.DNSv4.domain" = "";
        "network.connectivity-service.DNSv6.domain" = "";

        "services.sync.prefs.sync.browser.safebrowsing.malware.enabled" = false;

        "browser.safebrowsing.provider.google4.gethashURL" = "";

        "browser.safebrowsing.provider.google4.updateURL" = "";

        "browser.safebrowsing.provider.google.gethashURL" = "";

        "browser.safebrowsing.provider.google.updateURL" = "";

        "browser.safebrowsing.provider.google4.dataSharingURL" = "";

        "browser.safebrowsing.downloads.enabled" = false;

        "browser.safebrowsing.downloads.remote.enabled" = false;

        "browser.safebrowsing.downloads.remote.url" = "";

        "browser.safebrowsing.downloads.remote.block_dangerous" = false;

        "browser.safebrowsing.downloads.remote.block_dangerous_host" = false;
      };
    };
  };
}

