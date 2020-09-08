////////
// ui //
////////

// compact ui
user_pref('browser.uidensity', 1);
// do not automatically change to touch mode
user_pref('browser.touchmode.auto', false);

user_pref('gfx.use_text_smoothing_setting', true);
user_pref('toolkit.cosmeticAnimations.enabled', false);
user_pref('browser.history_swipe_animation.disabled', false);
user_pref('browser.formfill.enable', false);

// quitting
user_pref('browser.showQuitWarning', true);
user_pref('browser.warnOnQuit', true);

// fullscreen
user_pref('browser.fullscreen.autohide', true);
user_pref('browser.overlink-delay', 80);
user_pref('full-screen-api.warning.timeout', 0);

// startup
user_pref('browser.startup.page', 1);
user_pref('browser.startup.homepage', 'https://www.google.com/');
user_pref('browser.shell.checkDefaultBrowser', false);
user_pref('browser.slowStartup.notificationDisabled', false);
user_pref('browser.slowStartup.timeThreshold', 20000);
user_pref('browser.slowStartup.maxSamples', 5);

// favicons
user_pref('browser.shell.shortcutFavicons', true);
user_pref('browser.chrome.site_icons', true);

// tabs
user_pref('browser.tabs.extraDragSpace', false);
user_pref('browser.tabs.multiselect', true);
user_pref('browser.tabs.closeTabByDblclick', false);
user_pref('browser.tabs.closeWindowWithLastTab', false);
user_pref('browser.tabs.insertRelatedAfterCurrent', true);
user_pref('browser.tabs.insertAfterCurrent', false);
user_pref('browser.tabs.warnOnClose', true);
user_pref('browser.tabs.warnOnCloseOtherTabs', true);
user_pref('browser.tabs.warnOnOpen', true);
user_pref('browser.tabs.maxOpenBeforeWarn', 15);
user_pref('browser.tabs.selectOwnerOnClose', true);
user_pref('browser.tabs.loadInBackground', true);
user_pref('browser.tabs.opentabfor.middleclick', true);
user_pref('browser.tabs.loadDivertedInBackground', false);
user_pref('browser.tabs.loadBookmarksInBackground', false);
user_pref('browser.tabs.loadBookmarksInTabs', false);
user_pref('browser.tabs.tabClipWidth', 140);
user_pref('browser.tabs.tabMinWidth', 76);
user_pref('browser.tabs.showAudioPlayingIcon', true);
user_pref('browser.tabs.delayHidingAudioPlayingIconMS', 3000);
user_pref('browser.ctrlTab.recentlyUsedOrder', false);

// new tab
user_pref('browser.newtabpage.enabled', true);

// address bar
user_pref('keyword.enabled', true);
// do not search localhost
user_pref('browser.fixup.domainwhitelist.localhost', true);
user_pref('browser.urlbar.formatting.enabled', true);
user_pref('browser.urlbar.trimURLs', false);
user_pref('browser.urlbar.maxRichResults', 16);
user_pref('browser.urlbar.oneOffSearches', false);
user_pref('browser.urlbar.userMadeSearchSuggestionsChoice', false);
user_pref('browser.urlbar.timesBeforeHidingSuggestionsHint', 0);
user_pref('browser.urlbar.searchSuggestionsChoice', false);
user_pref('browser.urlbar.suggest.history', true);
user_pref('browser.urlbar.suggest.bookmark', true);
user_pref('browser.urlbar.suggest.openpage', true);
user_pref('browser.urlbar.suggest.searches', false);
user_pref('browser.urlbar.maxHistoricalSearchSuggestions', 0);
user_pref('browser.urlbar.maxCharsForSearchSuggestions', 20);
user_pref('browser.urlbar.delay', 1);
user_pref('browser.urlbar.autoFill', true);
user_pref('browser.urlbar.clickSelectsAll', false);
user_pref('browser.urlbar.doubleClickSelectsAll', true);
user_pref('browser.urlbar.decodeURLsOnCopy', false);
// ctrl + enter adds www and browser.fixup.alternate
user_pref('browser.urlbar.ctrlCanonizesURLs', true);
user_pref('browser.urlbar.filter.javascript', true);
user_pref('browser.urlbar.speculativeConnect.enabled', false);
user_pref('browser.urlbar.switchTabs.adoptIntoActiveWindow', false);
user_pref('browser.urlbar.openintab', false);

// search
user_pref('browser.search.openintab', false);
user_pref('browser.search.context.loadInBackground', true);
user_pref('ui.popup.disable_autohide', false);
user_pref('browser.altClickSave', false);
user_pref('browser.link.open_newwindow', 3);

// scrolling
user_pref('general.autoScroll', false);
user_pref('general.smoothScroll', true);
user_pref('general.smoothScroll.mouseWheel', true);
user_pref('general.smoothScroll.mouseWheel.durationMaxMS', 125);
user_pref('general.smoothScroll.mouseWheel.durationMinMS', 125);
user_pref('general.smoothScroll.lines', true);
user_pref('general.smoothScroll.lines.durationMaxMS', 125);
user_pref('general.smoothScroll.lines.durationMinMS', 125);
user_pref('general.smoothScroll.other', true);
user_pref('general.smoothScroll.other.durationMaxMS', 125);
user_pref('general.smoothScroll.other.durationMinMS', 125);
user_pref('general.smoothScroll.pages', true);
user_pref('general.smoothScroll.pages.durationMaxMS', 125);
user_pref('general.smoothScroll.pages.durationMinMS', 125);
user_pref('general.smoothScroll.pixels', true);
user_pref('general.smoothScroll.pixels.durationMaxMS', 125);
user_pref('general.smoothScroll.pixels.durationMinMS', 125);
user_pref('general.smoothScroll.scrollbars', true);
user_pref('general.smoothScroll.scrollbars.durationMaxMS', 125);
user_pref('general.smoothScroll.scrollbars.durationMinMS', 125);
user_pref('toolkit.scrollbox.smoothScroll', true);
user_pref('toolkit.scrollbox.horizontalScrollDistance', 6);
user_pref('toolkit.scrollbox.verticalScrollDistance', 3);

// 0: Nothing happens
// 1: Scrolling contents
// 2: Go back or go forward, in your history
// 3: Zoom in or out (reflowing zoom).
// 4: Treat vertical wheel as horizontal scroll
// 5: Zoom in or out (pinch zoom).
user_pref('mousewheel.with_shift.action', 4);
user_pref('mousewheel.with_control.action', 3);
user_pref('mousewheel.with_alt.action', 0);
user_pref('mousewheel.with_meta.action', 0); // win key on Win, Super/Hyper on Linux
user_pref('mousewheel.with_win.action', 0);

// zoom
user_pref('browser.zoom.full', true);
user_pref('browser.zoom.siteSpecific', true);
user_pref('browser.zoom.updateBackgroundTabs', true);

// fonts
user_pref('font.default.x-western', 'sans-serif');
user_pref('font.name.monospace.x-western', 'Hack');
user_pref('font.name.sans-serif.x-western', 'Inter');
user_pref('font.name.serif.x-western', 'Merriweather');
user_pref('font.size.variable.x-western', 14);

// downloads
user_pref('browser.download.autohideButton', false);
user_pref('browser.download.panel.shown', true);
user_pref('browser.download.save_converter_index', 0);
user_pref('browser.download.useDownloadDir', false);

// media
user_pref('media.autoplay.default', 1); // 0=Allowed, 1=Blocked
user_pref('media.autoplay.block-webaudio', true);
user_pref('browser.enable_automatic_image_resizing', true);

// reader
user_pref('reader.color_scheme', 'dark');
user_pref('reader.content_width', 5);
user_pref('reader.font_size', 4);

// sync
user_pref('services.sync.syncInterval', 600000);
user_pref('services.sync.syncThreshold', 300);
user_pref('signon.rememberSignons', false);

// performance
user_pref('browser.tabs.unloadOnLowMemory', false);
user_pref('browser.sessionstore.interval', 60000);

// bookmarks
user_pref('browser.bookmarks.autoExportHTML', false);
user_pref('browser.bookmarks.max_backups', 8);
user_pref('browser.bookmarks.openInTabClosesMenu', true);
user_pref('browser.bookmarks.showMobileBookmarks', true);

// devtools
user_pref('devtools.command-button-eyedropper.enabled', true);
user_pref('devtools.command-button-frames.enabled', false);
user_pref('devtools.command-button-measure.enabled', true);
user_pref('devtools.command-button-paintflashing.enabled', true);
user_pref('devtools.command-button-rulers.enabled', true);
user_pref('devtools.command-button-scratchpad.enabled', true);
user_pref('devtools.command-button-screenshot.enabled', true);
user_pref('devtools.dom.enabled', true);
user_pref('devtools.inspector.activeSidebar', 'computedview');
user_pref('devtools.inspector.showUserAgentStyles', true);
user_pref('devtools.theme', 'dark');
user_pref('devtools.webconsole.timestampMessages', true);

// security
user_pref('dom.disable_window_open_feature.location', true);
user_pref('dom.disable_window_move_resize', true);
user_pref('dom.disable_window_flip', true);

// privacy
user_pref('beacon.enabled', false);
user_pref('privacy.donottrackheader.enabled', true);
user_pref('dom.disable_open_during_load', true);
user_pref('privacy.popups.showBrowserMessage', false);
user_pref('privacy.trackingprotection.enabled', true);
user_pref('browser.selfsupport.enabled', false);
user_pref('permissions.eventTelemetry.enabled', false);
