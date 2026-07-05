import Foundation

final class SettingsRegistry {
    
    static let shared = SettingsRegistry()
    private let environment = SettingsEnvironment.current

    private(set) var entries: [SettingsEntry] = []

    private init() {
        buildRegistry()
    }

    private func buildRegistry() {

        let allEntries: [SettingsEntry] = [

            // MARK: - Network

            SettingsEntry(
                id: "wifi",
                displayName: "Wi-Fi",
                aliases: [
                    "wifi",
                    "internet",
                    "wireless",
                    "network"
                ],
                category: "Network",
                hierarchy: [
                    "Network",
                    "Wi-Fi"
                ],
                destination: .pane(
                    "com.apple.wifi-settings-extension"
                )
            ),

            SettingsEntry(
                id: "bluetooth",
                displayName: "Bluetooth",
                aliases: [
                    "bluetooth",
                    "wireless devices",
                    "connected devices"
                ],
                category: "Connectivity",
                hierarchy: [
                    "Bluetooth"
                ],
                destination: .pane(
                    "com.apple.BluetoothSettings"
                )
            ),

            // MARK: - Notifications & Focus

            SettingsEntry(
                id: "notifications",
                displayName: "Notifications",
                aliases: [
                    "notifications",
                    "alerts",
                    "app notifications",
                    "notification settings"
                ],
                category: "Notifications",
                hierarchy: [
                    "Notifications"
                ],
                destination: .pane(
                    "com.apple.Notifications-Settings.extension"
                )
            ),

            SettingsEntry(
                id: "focus",
                displayName: "Focus",
                aliases: [
                    "focus",
                    "do not disturb",
                    "dnd",
                    "focus mode"
                ],
                category: "Focus",
                hierarchy: [
                    "Focus"
                ],
                destination: .pane(
                    "com.apple.Focus-Settings.extension"
                )
            ),

            // MARK: - Screen Time

            SettingsEntry(
                id: "screen-time",
                displayName: "Screen Time",
                aliases: [
                    "screen time",
                    "usage time",
                    "app usage",
                    "device usage",
                    "downtime",
                    "app limits"
                ],
                category: "Screen Time",
                hierarchy: [
                    "Screen Time"
                ],
                destination: .pane(
                    "com.apple.Screen-Time-Settings.extension"
                )
            ),

            // MARK: - General

            SettingsEntry(
                id: "general",
                displayName: "General",
                aliases: [
                    "general",
                    "system settings"
                ],
                category: "System",
                hierarchy: [
                    "General"
                ],
                destination: .pane(
                    "com.apple.systempreferences.GeneralSettings"
                )
            ),

            SettingsEntry(
                id: "about",
                displayName: "About",
                aliases: [
                    "about",
                    "mac information",
                    "mac details",
                    "system information",
                    "macos version",
                    "serial number"
                ],
                category: "General",
                hierarchy: [
                    "General",
                    "About"
                ],

                // Safe fallback for versions where the
                // dedicated About extension is unavailable.
                destination: .pane(
                    "com.apple.systempreferences.GeneralSettings"
                ),

                destinationVariants: [

                    SettingsDestinationVariant(
                        destination: .pane(
                            "com.apple.SystemProfiler.AboutExtension"
                        ),
                        minimumMacOSMajorVersion: 26
                    )
                ]
            ),

            SettingsEntry(
                id: "software-update",
                displayName: "Software Update",
                aliases: [
                    "software update",
                    "system update",
                    "macos update",
                    "update mac",
                    "updates"
                ],
                category: "General",
                hierarchy: [
                    "General",
                    "Software Update"
                ],
                destination: .pane(
                    "com.apple.Software-Update-Settings.extension"
                )
            ),

            SettingsEntry(
                id: "storage",
                displayName: "Storage",
                aliases: [
                    "storage",
                    "disk space",
                    "free space",
                    "mac storage"
                ],
                category: "General",
                hierarchy: [
                    "General",
                    "Storage"
                ],
                destination: .pane(
                    "com.apple.settings.Storage"
                )
            ),

            SettingsEntry(
                id: "login-items",
                displayName: "Login Items & Extensions",
                aliases: [
                    "login items",
                    "startup apps",
                    "startup programs",
                    "open at login",
                    "background items",
                    "extensions"
                ],
                category: "General",
                hierarchy: [
                    "General",
                    "Login Items & Extensions"
                ],
                destination: .pane(
                    "com.apple.LoginItems-Settings.extension"
                )
            ),

            SettingsEntry(
                id: "sharing",
                displayName: "Sharing",
                aliases: [
                    "sharing",
                    "file sharing",
                    "screen sharing",
                    "media sharing",
                    "remote login",
                    "remote management"
                ],
                category: "General",
                hierarchy: [
                    "General",
                    "Sharing"
                ],
                destination: .pane(
                    "com.apple.Sharing-Settings.extension"
                )
            ),

            SettingsEntry(
                id: "time-machine",
                displayName: "Time Machine",
                aliases: [
                    "time machine",
                    "backup",
                    "mac backup",
                    "backup disk"
                ],
                category: "General",
                hierarchy: [
                    "General",
                    "Time Machine"
                ],
                destination: .pane(
                    "com.apple.Time-Machine-Settings.extension"
                )
            ),

            SettingsEntry(
                id: "date-time",
                displayName: "Date & Time",
                aliases: [
                    "date",
                    "time",
                    "date and time",
                    "time zone",
                    "timezone",
                    "clock"
                ],
                category: "General",
                hierarchy: [
                    "General",
                    "Date & Time"
                ],
                destination: .pane(
                    "com.apple.Date-Time-Settings.extension"
                )
            ),

            // MARK: - Appearance

            SettingsEntry(
                id: "appearance",
                displayName: "Appearance",
                aliases: [
                    "appearance",
                    "dark mode",
                    "light mode",
                    "automatic appearance",
                    "theme",
                    "accent color"
                ],
                category: "Personalization",
                hierarchy: [
                    "Appearance"
                ],
                destination: .pane(
                    "com.apple.Appearance-Settings.extension"
                ),
                capability: .choice
            ),

            SettingsEntry(
                id: "wallpaper",
                displayName: "Wallpaper",
                aliases: [
                    "wallpaper",
                    "background",
                    "desktop background",
                    "desktop picture"
                ],
                category: "Personalization",
                hierarchy: [
                    "Wallpaper"
                ],
                destination: .pane(
                    "com.apple.Wallpaper-Settings.extension"
                )
            ),

            SettingsEntry(
                id: "control-center",
                displayName: "Menu Bar",
                aliases: [
                    "menu bar",
                    "control center",
                    "menu bar settings",
                    "control centre"
                ],
                category: "Personalization",
                hierarchy: [
                    "Menu Bar"
                ],
                destination: .pane(
                    "com.apple.ControlCenter-Settings.extension"
                )
            ),

            // MARK: - Input

            SettingsEntry(
                id: "keyboard",
                displayName: "Keyboard",
                aliases: [
                    "keyboard",
                    "typing",
                    "keys",
                    "keyboard settings"
                ],
                category: "Input",
                hierarchy: [
                    "Keyboard"
                ],
                destination: .pane(
                    "com.apple.Keyboard-Settings.extension"
                )
            ),

            SettingsEntry(
                id: "keyboard-shortcuts",
                displayName: "Keyboard Shortcuts",
                aliases: [
                    "keyboard shortcuts",
                    "shortcuts",
                    "hotkeys",
                    "key bindings"
                ],
                category: "Keyboard",
                hierarchy: [
                    "Keyboard",
                    "Keyboard Shortcuts"
                ],

                // Safe fallback.
                destination: .pane(
                    "com.apple.Keyboard-Settings.extension"
                ),

                destinationVariants: [
                    SettingsDestinationVariant(
                        destination: .nested(
                            pane: "com.apple.Keyboard-Settings.extension",
                            anchor: "Shortcuts"
                        ),
                        minimumMacOSMajorVersion: 26
                    )
                ]
            ),

            SettingsEntry(
                id: "trackpad",
                displayName: "Trackpad",
                aliases: [
                    "trackpad",
                    "touchpad",
                    "gestures",
                    "trackpad settings"
                ],
                category: "Input",
                hierarchy: [
                    "Trackpad"
                ],
                destination: .pane(
                    "com.apple.Trackpad-Settings.extension"
                )
            ),

            SettingsEntry(
                id: "mouse",
                displayName: "Mouse",
                aliases: [
                    "mouse",
                    "mouse settings",
                    "scroll direction",
                    "tracking speed"
                ],
                category: "Input",
                hierarchy: [
                    "Mouse"
                ],
                destination: .pane(
                    "com.apple.Mouse-Settings.extension"
                )
            ),

            // MARK: - Displays & Sound

            SettingsEntry(
                id: "display",
                displayName: "Displays",
                aliases: [
                    "display",
                    "screen",
                    "monitor",
                    "resolution",
                    "brightness",
                    "refresh rate",
                    "night shift"
                ],
                category: "System",
                hierarchy: [
                    "Displays"
                ],
                destination: .pane(
                    "com.apple.Displays-Settings.extension"
                )
            ),

            SettingsEntry(
                id: "sound",
                displayName: "Sound",
                aliases: [
                    "sound",
                    "audio",
                    "volume",
                    "speaker",
                    "microphone",
                    "input volume",
                    "output volume"
                ],
                category: "System",
                hierarchy: [
                    "Sound"
                ],
                destination: .pane(
                    "com.apple.Sound-Settings.extension"
                )
            ),

            // MARK: - Battery

            SettingsEntry(
                id: "battery",
                displayName: "Battery",
                aliases: [
                    "battery",
                    "power",
                    "energy",
                    "charging",
                    "battery health",
                    "low power mode"
                ],
                category: "System",
                hierarchy: [
                    "Battery"
                ],
                destination: .pane(
                    "com.apple.Battery-Settings.extension"
                ),
                availability: SettingsAvailability(
                    requiresBattery: true
                )
            ),

            // MARK: - Accessibility

            SettingsEntry(
                id: "accessibility",
                displayName: "Accessibility",
                aliases: [
                    "accessibility",
                    "vision",
                    "hearing",
                    "motor",
                    "accessibility settings"
                ],
                category: "Accessibility",
                hierarchy: [
                    "Accessibility"
                ],
                destination: .pane(
                    "com.apple.Accessibility-Settings.extension"
                )
            ),

            // MARK: - Siri

            SettingsEntry(
                id: "siri",
                displayName: "Apple Intelligence & Siri",
                aliases: [
                    "siri",
                    "apple intelligence",
                    "ai",
                    "voice assistant"
                ],
                category: "System",
                hierarchy: [
                    "Apple Intelligence & Siri"
                ],
                destination: .pane(
                    "com.apple.Siri-Settings.extension"
                )
            ),

            // MARK: - Privacy & Security

            SettingsEntry(
                id: "privacy",
                displayName: "Privacy & Security",
                aliases: [
                    "privacy",
                    "security",
                    "permissions"
                ],
                category: "Security",
                hierarchy: [
                    "Privacy & Security"
                ],
                destination: .pane(
                    "com.apple.settings.PrivacySecurity.extension"
                )
            ),

            SettingsEntry(
                id: "location-services",
                displayName: "Location Services",
                aliases: [
                    "location services",
                    "location",
                    "gps",
                    "location permission"
                ],
                category: "Privacy & Security",
                hierarchy: [
                    "Privacy & Security",
                    "Location Services"
                ],
                destination: .nested(
                    pane: "com.apple.preference.security",
                    anchor: "Privacy_LocationServices"
                )
            ),

            SettingsEntry(
                id: "camera-access",
                displayName: "Camera Access",
                aliases: [
                    "camera",
                    "camera access",
                    "camera permission",
                    "apps using camera"
                ],
                category: "Privacy & Security",
                hierarchy: [
                    "Privacy & Security",
                    "Camera"
                ],
                destination: .nested(
                    pane: "com.apple.preference.security",
                    anchor: "Privacy_Camera"
                )
            ),

            SettingsEntry(
                id: "microphone-access",
                displayName: "Microphone Access",
                aliases: [
                    "microphone",
                    "mic",
                    "microphone access",
                    "microphone permission",
                    "mic permission",
                    "apps using microphone"
                ],
                category: "Privacy & Security",
                hierarchy: [
                    "Privacy & Security",
                    "Microphone"
                ],
                destination: .nested(
                    pane: "com.apple.preference.security",
                    anchor: "Privacy_Microphone"
                )
            ),

            SettingsEntry(
                id: "screen-recording-access",
                displayName: "Screen & System Audio Recording",
                aliases: [
                    "screen recording",
                    "screen recording permission",
                    "screen capture permission",
                    "system audio recording"
                ],
                category: "Privacy & Security",
                hierarchy: [
                    "Privacy & Security",
                    "Screen & System Audio Recording"
                ],
                destination: .nested(
                    pane: "com.apple.preference.security",
                    anchor: "Privacy_ScreenCapture"
                )
            ),

            SettingsEntry(
                id: "full-disk-access",
                displayName: "Full Disk Access",
                aliases: [
                    "full disk access",
                    "disk permission",
                    "file access permission"
                ],
                category: "Privacy & Security",
                hierarchy: [
                    "Privacy & Security",
                    "Full Disk Access"
                ],
                destination: .nested(
                    pane: "com.apple.preference.security",
                    anchor: "Privacy_AllFiles"
                )
            ),

            SettingsEntry(
                id: "accessibility-permission",
                displayName: "Accessibility Permissions",
                aliases: [
                    "accessibility permission",
                    "accessibility access",
                    "control my mac permission"
                ],
                category: "Privacy & Security",
                hierarchy: [
                    "Privacy & Security",
                    "Accessibility"
                ],
                destination: .nested(
                    pane: "com.apple.preference.security",
                    anchor: "Privacy_Accessibility"
                )
            ),

            SettingsEntry(
                id: "automation-permission",
                displayName: "Automation Permissions",
                aliases: [
                    "automation",
                    "automation permission",
                    "control other apps"
                ],
                category: "Privacy & Security",
                hierarchy: [
                    "Privacy & Security",
                    "Automation"
                ],
                destination: .nested(
                    pane: "com.apple.preference.security",
                    anchor: "Privacy_Automation"
                )
            ),

            SettingsEntry(
                id: "filevault",
                displayName: "FileVault",
                aliases: [
                    "filevault",
                    "disk encryption",
                    "encrypt mac",
                    "encryption"
                ],
                category: "Privacy & Security",
                hierarchy: [
                    "Privacy & Security",
                    "FileVault"
                ],

                // Safe fallback.
                destination: .pane(
                    "com.apple.settings.PrivacySecurity.extension"
                ),

                destinationVariants: [
                    SettingsDestinationVariant(
                        destination: .nested(
                            pane: "com.apple.settings.PrivacySecurity.extension",
                            anchor: "FileVault"
                        ),
                        minimumMacOSMajorVersion: 26
                    )
                ]
            ),

            SettingsEntry(
                id: "firewall",
                displayName: "Firewall",
                aliases: [
                    "firewall",
                    "network security",
                    "block connections"
                ],
                category: "Privacy & Security",
                hierarchy: [
                    "Privacy & Security",
                    "Firewall"
                ],
                destination: .nested(
                    pane: "com.apple.Network-Settings.extension",
                    anchor: "firewall"
                )
            ),

            // MARK: - Lock Screen & Users

            SettingsEntry(
                id: "lock-screen",
                displayName: "Lock Screen",
                aliases: [
                    "lock screen",
                    "screen lock",
                    "password after sleep",
                    "turn display off"
                ],
                category: "Security",
                hierarchy: [
                    "Lock Screen"
                ],
                destination: .pane(
                    "com.apple.Lock-Screen-Settings.extension"
                )
            ),

            // MARK: - Touch ID

            SettingsEntry(
                id: "touch-id",
                displayName: "Touch ID",
                aliases: [
                    "touch id",
                    "fingerprint",
                    "fingerprint settings",
                    "add fingerprint",
                    "remove fingerprint"
                ],
                category: "Security",
                hierarchy: [
                    "Touch ID & Password",
                    "Touch ID"
                ],
                destination: .pane(
                    "com.apple.Touch-ID-Settings.extension"
                ),
                availability: SettingsAvailability(
                    requiresTouchID: true
                )
            ),

            // MARK: - Password

            SettingsEntry(
                id: "login-password",
                displayName: "Login Password",
                aliases: [
                    "password",
                    "login password",
                    "mac password",
                    "change password",
                    "computer password",
                    "user password"
                ],
                category: "Security",
                hierarchy: [
                    "Touch ID & Password",
                    "Password"
                ],
                destination: .pane(
                    "com.apple.Touch-ID-Settings.extension"
                )
            ),

            SettingsEntry(
                id: "users-groups",
                displayName: "Users & Groups",
                aliases: [
                    "users",
                    "groups",
                    "user account",
                    "accounts",
                    "new user"
                ],
                category: "System",
                hierarchy: [
                    "Users & Groups"
                ],
                destination: .pane(
                    "com.apple.Users-Groups-Settings.extension"
                )
            ),

            // MARK: - Accounts & Devices

            SettingsEntry(
                id: "internet-accounts",
                displayName: "Internet Accounts",
                aliases: [
                    "internet accounts",
                    "email accounts",
                    "google account",
                    "account settings"
                ],
                category: "Accounts",
                hierarchy: [
                    "Internet Accounts"
                ],
                destination: .pane(
                    "com.apple.Internet-Accounts-Settings.extension"
                )
            ),

            SettingsEntry(
                id: "printers-scanners",
                displayName: "Printers & Scanners",
                aliases: [
                    "printer",
                    "printers",
                    "scanner",
                    "scanners",
                    "printing"
                ],
                category: "Devices",
                hierarchy: [
                    "Printers & Scanners"
                ],
                destination: .pane(
                    "com.apple.Print-Scan-Settings.extension"
                )
            ),

            SettingsEntry(
                id: "game-center",
                displayName: "Game Center",
                aliases: [
                    "game center",
                    "gaming account",
                    "games"
                ],
                category: "Accounts",
                hierarchy: [
                    "Game Center"
                ],
                destination: .pane(
                    "com.apple.Game-Center-Settings.extension"
                )
            )
        ]
        
        entries = allEntries.filter {

            $0.availability.isAvailable(

                in: environment

            )

        }
    }
}
