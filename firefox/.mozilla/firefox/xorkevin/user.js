// compact ui
user_pref('browser.uidensity', 1);

// tabs
user_pref('browser.tabs.closeWindowWithLastTab', false);
user_pref('browser.tabs.warnOnClose', true);

// do not search localhost
user_pref('browser.urlbar.trimURLs', false);

// 0: Nothing happens
// 1: Scrolling contents
// 2: Go back or go forward, in your history
// 3: Zoom in or out (reflowing zoom).
// 4: Treat vertical wheel as horizontal scroll
// 5: Zoom in or out (pinch zoom).
user_pref('mousewheel.with_alt.action', 0);
user_pref('mousewheel.with_meta.action', 0); // win key on Win, Super/Hyper on Linux

// fonts
user_pref('font.default.x-western', 'sans-serif');
user_pref('font.size.variable.x-western', 14);

// downloads
user_pref('browser.download.autohideButton', false);

// performance
user_pref('browser.sessionstore.interval', 60000);
