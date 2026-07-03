import SwiftUI

struct AIView: View {

    @StateObject
    private var settings = AISettingsManager.shared

    var body: some View {

        Form {

            PageHeader(
                title: "AI",
                subtitle: "Configure JAM's AI providers.",
                systemImage: "sparkles"
            )

            SettingsCard(
                title: "Provider",
                systemImage: "brain"
            ) {

                LabeledContent("AI Provider") {

                    Picker(
                        "",
                        selection: $settings.provider
                    ) {

                        ForEach(AIProvider.allCases) { provider in

                            Text(provider.rawValue)
                                .tag(provider)

                        }

                    }
                    .labelsHidden()
                    .pickerStyle(.menu)

                }

            }
           
            
           SettingsCard(
                title: "Authentication",
                systemImage: "key.fill"
            ) {
                
                VStack(alignment: .leading, spacing: 10) {

                    Text("API Key")
                        .font(.headline)

                    HStack(spacing: 10) {

                        if settings.revealAPIKey {

                            TextField(
                                "Enter your API Key",
                                text: $settings.apiKey
                            )

                        } else {

                            SecureField(
                                "Enter your API Key",
                                text: $settings.apiKey
                            )

                        }

                        Button {

                            settings.revealAPIKey.toggle()

                        } label: {

                            Image(
                                systemName: settings.revealAPIKey
                                ? "eye.slash"
                                : "eye"
                            )

                            .foregroundStyle(.secondary)

                        }
                        .buttonStyle(.plain)

                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(
                        Color.white.opacity(0.08)
                    )
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
                    Text("Your API key will be stored securely in your macOS Keychain.")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                }
                
                Divider()

                HStack {

                    Spacer()

                    Button {

                        Task {

                            settings.connectionState = .testing

                            do {

                                try await AIConnectionManager.shared.testConnection()

                                settings.connectionState = .connected

                            } catch {

                                settings.connectionState = .failed(error.localizedDescription)

                            }

                        }

                    } label: {

                        switch settings.connectionState {

                        case .testing:

                            ProgressView()

                        default:

                            Text("Test Connection")

                        }

                    }
                    .disabled(settings.apiKey.isEmpty)

                }
            }

            SettingsCard(
                title: "Features",
                systemImage: "sparkles"
            ) {

                Toggle(
                    "AI Suggestions",
                    isOn: $settings.suggestionsEnabled
                )

                Divider()

                Toggle(
                    "Streaming Responses",
                    isOn: $settings.streamingEnabled
                )

            }

            SettingsCard(
                title: "Status",
                systemImage: "checkmark.shield"
            ) {

                LabeledContent("Provider") {

                    Text(settings.provider.rawValue)

                }

                Divider()
                LabeledContent("Connection") {

                    switch settings.connectionState {

                    case .notConfigured:

                        StatusBadge(
                            title: "Not Configured",
                            systemImage: "exclamationmark.triangle.fill",
                            color: .orange
                        )

                    case .notTested:

                        StatusBadge(
                            title: "Not Tested",
                            systemImage: "clock.fill",
                            color: .yellow
                        )

                    case .testing:

                        ProgressView()

                    case .connected:

                        StatusBadge(
                            title: "Connected",
                            systemImage: "checkmark.circle.fill",
                            color: .green
                        )

                    case .failed:

                        StatusBadge(
                            title: "Connection Failed",
                            systemImage: "xmark.circle.fill",
                            color: .red
                        )

                    }

                }

            }

        }
        .formStyle(.grouped)

    }

}
