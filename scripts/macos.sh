configure_macos_tray() {
  osascript -e 'tell application "System Preferences" to quit'

  defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
  echo Configuring macOS tray icons
  # systray
  defaults write com.apple.systemuiserver menuExtras -array \
    "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
    "/System/Library/CoreServices/Menu Extras/Volume.menu" \
    "/System/Library/CoreServices/Menu Extras/Clock.menu" \
    "/System/Library/CoreServices/Menu Extras/AirPort.menu"
  defaults write com.apple.menuextra.battery ShowPercent YES
  killall SystemUIServer
}
