import SwiftUI

struct AppearanceView: View {

    @StateObject
    private var settings = AppearanceSettingsManager.shared

    var body: some View {

        Form {

            Section("Theme") {

                Picker(
                    "Appearance",
                    selection: $settings.selectedTheme
                ) {

                    Text("System")
                        .tag(AppTheme.system)

                    Text("Light")
                        .tag(AppTheme.light)

                    Text("Dark")
                        .tag(AppTheme.dark)

                }
                .pickerStyle(.radioGroup)

            }

            Section("Effects") {

                Toggle(
                    "Animations",
                    isOn: $settings.animationsEnabled
                )

                Toggle(
                    "Glass Effects",
                    isOn: $settings.glassEffectsEnabled
                )

                Toggle(
                    "Background Blur",
                    isOn: $settings.blurBackgroundEnabled
                )

            }

            Section("Preview") {

                HStack {

                    Spacer()

                    VStack(spacing: 12) {

                        Image(systemName: "sparkles")

                            .font(.system(size: 40))

                        Text("JAM")

                            .font(.title2.bold())

                        Text("Native Assistant")

                            .foregroundStyle(.secondary)

                    }

                    Spacer()

                }
                .padding(.vertical)

            }

        }
        .formStyle(.grouped)

    }

}
