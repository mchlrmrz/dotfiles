#!/usr/bin/env bash

# ~/osx.sh — Originally from https://mths.be/osx

# Helper functions to work with preferences.

# Write preferences.
function preferences_import_header() { e_header "Importing preferences"; }
function import_preferences() {
  e_success "Importing preferences for ~/$1."
  defaults import "$1" "$2"
}

# Read preferences.
function preferences_read_header() { e_header "Reading preferences"; }
function read_preferences() {
  e_success "Reading preferences for ~/$1."
  defaults read "$1"
}

# Export preferences.
function preferences_export_header() { e_header "Exporting preferences"; }
function export_preferences() {
  e_success "Exporting preferences for ~/$1."
  defaults export "$1" "$2"
}

pref_folder="$DOTFILES/conf/osx/preferences"

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `osx.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName "MacBook-Pro"
sudo scutil --set HostName "MacBook-Pro"
sudo scutil --set LocalHostName "MacBook-Pro"

# Set the timezone; see `sudo systemsetup -listtimezones` for other values
sudo systemsetup -settimezone "America/New_York" > /dev/null

# Import preferences to NSGlobalDomain
preferences_import_header
import_preferences NSGlobalDomain "$pref_folder/"NSGlobalDomain.plist
import_preferences com.agilebits.onepassword4 "$pref_folder/"com.agilebits.onepassword4.plist
import_preferences com.apple.ActivityMonitor "$pref_folder/"com.apple.ActivityMonitor.plist
import_preferences com.apple.dock "$pref_folder/"com.apple.dock.plist
import_preferences com.apple.finder "$pref_folder/"com.apple.finder.plist
import_preferences com.apple.iChat "$pref_folder/"com.apple.iChat.plist
import_preferences com.apple.menuextra.battery "$pref_folder/"com.apple.menuextra.battery.plist
import_preferences com.apple.print.PrintingPrefs "$pref_folder/"com.apple.print.PrintingPrefs.plist
import_preferences com.apple.Safari "$pref_folder/"com.apple.Safari.plist
import_preferences com.apple.SoftwareUpdate "$pref_folder/"com.apple.SoftwareUpdate.plist
import_preferences com.apple.Spotlight "$pref_folder/"com.apple.Spotlight.plist
import_preferences com.apple.systempreferences "$pref_folder/"com.apple.systempreferences.plist
import_preferences com.apple.systemsound "$pref_folder/"com.apple.systemsound.plist
import_preferences com.apple.Terminal "$pref_folder/"com.apple.Terminal.plist
import_preferences com.apple.TimeMachine "$pref_folder/"com.apple.TimeMachine.plist
import_preferences com.fatcatsoftware.pledpro "$pref_folder/"com.fatcatsoftware.pledpro.plist
import_preferences com.fournova.Tower2 "$pref_folder/"com.fournova.Tower2.plist
import_preferences com.hegenberg.BetterTouchTool "$pref_folder/"com.hegenberg.BetterTouchTool.plist
import_preferences com.manytricks.Moom "$pref_folder/"com.manytricks.Moom.plist
import_preferences com.pilotmoon.popclip "$pref_folder/"com.pilotmoon.popclip.plist
import_preferences com.smileonmymac.textexpander "$pref_folder/"com.smileonmymac.textexpander.plist
import_preferences com.surteesstudios.Bartender "$pref_folder/"com.surteesstudios.Bartender.plist
import_preferences org.m0k.transmission "$pref_folder/"org.m0k.transmission.plist
# import_preferences at.obdev.LaunchBar "$pref_folder/"at.obdev.LaunchBar.plist
import_preferences cx.c3.theunarchiver "$pref_folder/"cx.c3.theunarchiver.plist

# Disable local Time Machine snapshots
sudo tmutil disablelocal

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Reset Launchpad, but keep the desktop wallpaper intact
find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete

# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

# Load new settings before rebuilding the index
killall mds > /dev/null 2>&1
# Make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null
# Rebuild the index from scratch
sudo mdutil -E / > /dev/null

# Disable local Time Machine backups
hash tmutil &> /dev/null && sudo tmutil disablelocal

# Install Sublime Text settings
# ditto conf/osx/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings 2> /dev/null

for app in "Activity Monitor" "cfprefsd" \
    "Dock" "Finder" "Messages" \
    "Safari" "SystemUIServer" \
    "Transmission"; do
    killall "${app}" > /dev/null 2>&1
done
echo "Done. Note that some of these changes require a logout/restart of your OS to take effect.  At a minimum, be sure to restart your Terminal."
