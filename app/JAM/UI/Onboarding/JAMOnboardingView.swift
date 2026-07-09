import SwiftUI

struct JAMOnboardingView: View {

    @Environment(\.colorScheme)
    private var colorScheme

    @State
    private var currentStep = 0

    @State
    private var onboardingName = ""

    @StateObject
    private var settings = SettingsManager.shared

    private let finalStep = 5

    private var subtleBackground: Color {

        colorScheme == .dark
            ? Color.white.opacity(0.04)
            : Color.black.opacity(0.055)
    }

    private var cardBackground: Color {

        colorScheme == .dark
            ? Color.white.opacity(0.05)
            : Color.black.opacity(0.06)
    }

    private var subtleBorder: Color {

        colorScheme == .dark
            ? Color.white.opacity(0.08)
            : Color.black.opacity(0.12)
    }


    // MARK: - Body

    var body: some View {

        HStack(spacing: 0) {

            onboardingSidebar

            Divider()
                .opacity(0.6)

            VStack(spacing: 0) {

                ZStack {

                    switch currentStep {

                    case 0:
                        welcomePage

                    case 1:
                        searchPage

                    case 2:
                        actionsPage

                    case 3:
                        privacyPage

                    case 4:
                        availabilityPage

                    case 5:
                        readyPage

                    default:
                        EmptyView()
                    }
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .padding(.horizontal, 40)
                .padding(.top, 32)
                .padding(.bottom, 20)

                Divider()
                    .opacity(0.5)

                navigationBar
                    .padding(.horizontal, 40)
                    .frame(height: 72)
            }
        }
        .frame(
            minWidth: 900,
            idealWidth: 960,
            minHeight: 620,
            idealHeight: 660
        )
        .background(
            Color(nsColor: .windowBackgroundColor)
        )
    }


    // MARK: - Sidebar

    private var onboardingSidebar: some View {

        VStack(alignment: .leading, spacing: 0) {

            HStack(spacing: 12) {

                Image(systemName: "sparkles")
                    .symbolVariant(.fill)
                    .font(.system(size: 30))

                VStack(alignment: .leading, spacing: 2) {

                    Text("JAM")
                        .font(.title2.bold())

                    Text("Setup")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            VStack(alignment: .leading, spacing: 8) {

                sidebarStep(
                    index: 0,
                    title: "Welcome",
                    systemImage: "hand.wave"
                )

                sidebarStep(
                    index: 1,
                    title: "Search",
                    systemImage: "magnifyingglass"
                )

                sidebarStep(
                    index: 2,
                    title: "Actions",
                    systemImage: "bolt"
                )

                sidebarStep(
                    index: 3,
                    title: "Privacy",
                    systemImage: "lock.shield"
                )

                sidebarStep(
                    index: 4,
                    title: "Availability",
                    systemImage: "keyboard"
                )

                sidebarStep(
                    index: 5,
                    title: "Ready",
                    systemImage: "checkmark.circle"
                )
            }
            .padding(.top, 40)

            Spacer()

            HStack(spacing: 8) {

                Image(systemName: "lock.fill")

                Text("Designed for your Mac")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(28)
        .frame(width: 210)
        .background(
            subtleBackground
        )
    }


    private func sidebarStep(
        index: Int,
        title: String,
        systemImage: String
    ) -> some View {

        Button {

            withAnimation(.easeInOut(duration: 0.2)) {
                currentStep = index
            }

        } label: {

            HStack(spacing: 12) {

                ZStack {

                    Circle()
                        .fill(
                            index == currentStep
                                ? Color.accentColor
                                : subtleBackground
                        )
                        .frame(width: 30, height: 30)

                    if index < currentStep {

                        Image(systemName: "checkmark")
                            .font(.caption.bold())
                            .foregroundStyle(.white)

                    } else {

                        Image(systemName: systemImage)
                            .font(.caption.bold())
                            .foregroundStyle(
                                index == currentStep
                                    ? .white
                                    : .secondary
                            )
                    }
                }

                Text(title)
                    .font(
                        .subheadline.weight(
                            index == currentStep
                                ? .semibold
                                : .regular
                        )
                    )
                    .foregroundStyle(
                        index == currentStep
                            ? .primary
                            : .secondary
                    )

                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 7)
            .contentShape(Rectangle())
            .background {

                if index == currentStep {

                    RoundedRectangle(cornerRadius: 9)
                        .fill(
                            Color.accentColor.opacity(0.09)
                        )
                }
            }
        }
        .buttonStyle(.plain)
    }


    // MARK: - Welcome

    private var welcomePage: some View {

        VStack(spacing: 26) {

            Spacer()

            onboardingSymbol(
                "sparkles"
            )

            VStack(spacing: 10) {

                Text("Welcome to JAM")
                    .font(
                        .system(
                            size: 38,
                            weight: .bold
                        )
                    )

                Text("Your Mac, one command away.")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }

            VStack(alignment: .leading, spacing: 8) {

                Text("What should JAM call you?")
                    .font(.subheadline.weight(.medium))

                TextField(
                    "Your name",
                    text: $onboardingName
                )
                .textFieldStyle(.roundedBorder)
                .frame(width: 320)
            }
            .padding(.top, 8)

            Text(
                "JAM gives you one fast place to find things and control your Mac."
            )
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: 440)

            Spacer()
        }
    }


    // MARK: - Search

    private var searchPage: some View {

        VStack(spacing: 16) {

            compactPageHeader(
                systemImage: "magnifyingglass",
                title: "Find what you need",
                subtitle:
                    "Search across your Mac from one focused interface."
            )

            VStack(spacing: 8) {

                featureRow(
                    systemImage: "square.grid.2x2",
                    title: "Applications",
                    description:
                        "Find and open installed applications."
                )

                featureRow(
                    systemImage: "doc",
                    title: "Files",
                    description:
                        "Search files across your everyday folders."
                )

                featureRow(
                    systemImage: "folder",
                    title: "Folders",
                    description:
                        "Find folders, including items nested inside other folders."
                )

                featureRow(
                    systemImage: "gearshape",
                    title: "System Settings",
                    description:
                        "Jump directly to settings on your Mac."
                )
            }
            .frame(maxWidth: 560)

            searchPreview
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .center
        )
    }


    private var searchPreview: some View {

        HStack(spacing: 12) {

            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            Text(
                "Search applications, files, folders, and settings"
            )
            .foregroundStyle(.secondary)

            Spacer()

            Text("⌥ J")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    subtleBackground,
                    in: RoundedRectangle(cornerRadius: 6)
                )
        }
        .padding(16)
        .background(
            cardBackground,
            in: RoundedRectangle(cornerRadius: 14)
        )
        .overlay {

            RoundedRectangle(cornerRadius: 14)
                .stroke(
                    subtleBorder,
                    lineWidth: 1
                )
        }
        .frame(maxWidth: 560)
    }


    // MARK: - Actions

    private var actionsPage: some View {

        VStack(spacing: 20) {

            pageHeader(
                systemImage: "bolt.fill",
                title: "More than search",
                subtitle:
                    "JAM can perform useful actions without interrupting your workflow."
            )

            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible())
                ],
                spacing: 12
            ) {

                actionCard(
                    systemImage: "arrow.up.forward.app",
                    title: "Open Items",
                    description:
                        "Launch applications and open files or folders."
                )

                actionCard(
                    systemImage: "xmark.app",
                    title: "Quit Applications",
                    description:
                        "Find and quit a running application."
                )

                actionCard(
                    systemImage: "rectangle.stack.badge.minus",
                    title: "Quit All",
                    description:
                        "Close your open applications with one command."
                )

                actionCard(
                    systemImage: "eye.slash",
                    title: "Hide All",
                    description:
                        "Clear your workspace by hiding open applications."
                )
            }
            .frame(maxWidth: 570)

            Text(
                "Type what you want to do, choose a result, and JAM handles the rest."
            )
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .center
        )
    }


    // MARK: - Privacy

    private var privacyPage: some View {

        VStack(spacing: 28) {

            pageHeader(
                systemImage: "lock.shield.fill",
                title: "Your Mac stays yours",
                subtitle:
                    "JAM is designed around local search and clear control over your data."
            )

            VStack(spacing: 10) {

                privacyRow(
                    systemImage: "internaldrive",
                    title: "Local Search Index",
                    description:
                        "JAM builds its file and folder search index on your Mac."
                )

                privacyRow(
                    systemImage: "arrow.triangle.2.circlepath",
                    title: "Automatic Updates",
                    description:
                        "File changes are detected so search results stay current."
                )

                privacyRow(
                    systemImage: "eye.slash",
                    title: "No Unnecessary Uploads",
                    description:
                        "Your local files are not uploaded just to make search work."
                )

                privacyRow(
                    systemImage: "hand.raised",
                    title: "You Stay in Control",
                    description:
                        "JAM uses the capabilities needed for the features you choose to use."
                )
            }
            .frame(maxWidth: 570)
        }
    }


    // MARK: - Availability

    private var availabilityPage: some View {

        VStack(spacing: 28) {

            pageHeader(
                systemImage: "keyboard.fill",
                title: "Always within reach",
                subtitle:
                    "Choose how JAM fits into your everyday workflow."
            )

            VStack(spacing: 0) {

                settingRow(
                    systemImage: "keyboard",
                    title: "Global Shortcut",
                    description:
                        "Open JAM from anywhere using ⌥ J."
                ) {

                    Toggle(
                        "",
                        isOn: $settings.launcherShortcutEnabled
                    )
                    .labelsHidden()
                }

                Divider()
                    .padding(.leading, 48)

                settingRow(
                    systemImage: "power",
                    title: "Launch at Login",
                    description:
                        "Have JAM ready automatically when you log in."
                ) {

                    Toggle(
                        "",
                        isOn: $settings.launchAtLogin
                    )
                    .labelsHidden()
                }
            }
            .background(
                cardBackground,
                in: RoundedRectangle(cornerRadius: 14)
            )
            .overlay {

                RoundedRectangle(cornerRadius: 14)
                    .stroke(
                        subtleBorder,
                        lineWidth: 1
                    )
            }
            .frame(maxWidth: 570)

            Text(
                "You can change these options later in JAM Settings."
            )
            .font(.caption)
            .foregroundStyle(.secondary)
        }
    }


    // MARK: - Ready

    private var readyPage: some View {

        VStack(spacing: 26) {

            Spacer()

            ZStack {

                Circle()
                    .fill(Color.green.opacity(0.12))
                    .frame(width: 104, height: 104)

                Image(systemName: "checkmark")
                    .font(
                        .system(
                            size: 44,
                            weight: .bold
                        )
                    )
                    .foregroundStyle(.green)
            }

            VStack(spacing: 10) {

                Text(readyTitle)
                    .font(
                        .system(
                            size: 36,
                            weight: .bold
                        )
                    )

                Text(
                    "JAM is ready to help you find things and control your Mac."
                )
                .font(.title3)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 500)
            }

            HStack(spacing: 20) {

                readyFeature(
                    "magnifyingglass",
                    "Search"
                )

                readyFeature(
                    "bolt.fill",
                    "Actions"
                )

                readyFeature(
                    "keyboard",
                    "⌥ J"
                )
            }
            .padding(.top, 10)

            Spacer()
        }
    }


    private var readyTitle: String {

        let name =
            onboardingName
                .trimmingCharacters(
                    in: .whitespacesAndNewlines
                )

        if name.isEmpty {
            return "You're ready."
        }

        return "You're ready, \(name)."
    }


    // MARK: - Navigation

    private var navigationBar: some View {

        HStack {

            Button("Back") {

                guard currentStep > 0 else {
                    return
                }

                withAnimation(.easeInOut(duration: 0.2)) {
                    currentStep -= 1
                }
            }
            .disabled(currentStep == 0)
            .opacity(currentStep == 0 ? 0 : 1)

            Spacer()

            HStack(spacing: 6) {

                ForEach(
                    0...finalStep,
                    id: \.self
                ) { index in

                    Capsule()
                        .fill(
                            index == currentStep
                                ? Color.accentColor
                                : Color.primary.opacity(0.12)
                        )
                        .frame(
                            width: index == currentStep
                                ? 22
                                : 7,
                            height: 7
                        )
                }
            }

            Spacer()

            Button(
                currentStep == finalStep
                    ? "Start Using JAM"
                    : "Continue"
            ) {

                if currentStep < finalStep {

                    withAnimation(.easeInOut(duration: 0.2)) {
                        currentStep += 1
                    }

                } else {

                    AppStateManager.shared.preferredName =
                        onboardingName.trimmingCharacters(
                            in: .whitespacesAndNewlines
                        )

                    JAMApplication.shared.completeOnboarding()
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }


    // MARK: - Shared Components

    private func onboardingSymbol(
        _ systemImage: String
    ) -> some View {

        ZStack {

            RoundedRectangle(cornerRadius: 24)
                .fill(Color.accentColor.opacity(0.12))
                .frame(width: 104, height: 104)

            Image(systemName: systemImage)
                .symbolVariant(.fill)
                .font(.system(size: 52))
                .foregroundStyle(Color.accentColor)
        }
    }


    private func pageHeader(
        systemImage: String,
        title: String,
        subtitle: String
    ) -> some View {

        VStack(spacing: 12) {

            onboardingSymbol(systemImage)

            Text(title)
                .font(
                    .system(
                        size: 34,
                        weight: .bold
                    )
                )

            Text(subtitle)
                .font(.title3)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 540)
        }
    }


    private func compactPageHeader(
        systemImage: String,
        title: String,
        subtitle: String
    ) -> some View {

        VStack(spacing: 8) {

            ZStack {

                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.accentColor.opacity(0.12))
                    .frame(width: 82, height: 82)

                Image(systemName: systemImage)
                    .symbolVariant(.fill)
                    .font(.system(size: 40))
                    .foregroundStyle(Color.accentColor)
            }

            Text(title)
                .font(
                    .system(
                        size: 32,
                        weight: .bold
                    )
                )

            Text(subtitle)
                .font(.title3)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 540)
        }
    }


    private func featureRow(
        systemImage: String,
        title: String,
        description: String
    ) -> some View {

        HStack(spacing: 16) {

            featureIcon(systemImage)

            VStack(alignment: .leading, spacing: 3) {

                Text(title)
                    .font(.headline)

                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(14)
        .background(
            cardBackground,
            in: RoundedRectangle(cornerRadius: 12)
        )
        .overlay {

            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    subtleBorder,
                    lineWidth: 1
                )
        }
    }


    private func actionCard(
        systemImage: String,
        title: String,
        description: String
    ) -> some View {

        VStack(alignment: .leading, spacing: 12) {

            featureIcon(systemImage)

            Text(title)
                .font(.headline)

            Text(description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )

            Spacer(minLength: 0)
        }
        .frame(
            maxWidth: .infinity,
            minHeight: 105,
            maxHeight: 105,
            alignment: .leading
        )
        .padding(16)
        .background(
            cardBackground,
            in: RoundedRectangle(cornerRadius: 14)
        )
        .overlay {

            RoundedRectangle(cornerRadius: 14)
                .stroke(
                    subtleBorder,
                    lineWidth: 1
                )
        }
    }


    private func privacyRow(
        systemImage: String,
        title: String,
        description: String
    ) -> some View {

        HStack(spacing: 16) {

            ZStack {

                Circle()
                    .fill(Color.green.opacity(0.11))
                    .frame(width: 38, height: 38)

                Image(systemName: systemImage)
                    .foregroundStyle(.green)
            }

            VStack(alignment: .leading, spacing: 3) {

                Text(title)
                    .font(.headline)

                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
        }
        .padding(14)
        .background(
            cardBackground,
            in: RoundedRectangle(cornerRadius: 12)
        )
        .overlay {

            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    subtleBorder,
                    lineWidth: 1
                )
        }
    }


    private func settingRow<Accessory: View>(
        systemImage: String,
        title: String,
        description: String,
        @ViewBuilder accessory: () -> Accessory
    ) -> some View {

        HStack(spacing: 14) {

            featureIcon(systemImage)

            VStack(alignment: .leading, spacing: 3) {

                Text(title)
                    .font(.headline)

                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            accessory()
        }
        .padding(16)
    }


    private func featureIcon(
        _ systemImage: String
    ) -> some View {

        ZStack {

            RoundedRectangle(cornerRadius: 9)
                .fill(Color.accentColor.opacity(0.1))
                .frame(width: 38, height: 38)

            Image(systemName: systemImage)
                .foregroundStyle(Color.accentColor)
        }
    }


    private func readyFeature(
        _ systemImage: String,
        _ title: String
    ) -> some View {

        HStack(spacing: 7) {

            Image(systemName: systemImage)

            Text(title)
        }
        .font(.subheadline.weight(.medium))
        .foregroundStyle(.secondary)
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            subtleBackground,
            in: Capsule()
        )
    }
}
