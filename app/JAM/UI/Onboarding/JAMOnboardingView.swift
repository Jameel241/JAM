import SwiftUI

struct JAMOnboardingView: View {

    @State
    private var currentStep = 0

    private let finalStep = 4

    var body: some View {

        VStack(spacing: 0) {

            ZStack {

                switch currentStep {

                case 0:
                    welcomePage

                case 1:
                    searchPage

                case 2:
                    shortcutPage

                case 3:
                    launchAtLoginPage

                case 4:
                    readyPage

                default:
                    EmptyView()
                }

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            navigationBar

        }
        .frame(
            minWidth: 760,
            minHeight: 520
        )
        .padding(48)

    }

    // MARK: - Pages

    private var welcomePage: some View {

        VStack(spacing: 24) {

            Spacer()

            Text("JAM")
                .font(.system(size: 64, weight: .bold))

            Text("Your Mac, one command away.")
                .font(.title2)
                .foregroundStyle(.secondary)

            Spacer()

        }

    }

    private var searchPage: some View {

        VStack(spacing: 24) {

            Spacer()

            Image(systemName: "magnifyingglass")
                .font(.system(size: 52))

            Text("Find what you need.")
                .font(.largeTitle.bold())

            Text(
                "JAM can search your applications, files, folders, and system settings."
            )
            .font(.title3)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: 500)

            Spacer()

        }

    }

    private var shortcutPage: some View {

        VStack(spacing: 24) {

            Spacer()

            Image(systemName: "keyboard")
                .font(.system(size: 52))

            Text("JAM is always one shortcut away.")
                .font(.largeTitle.bold())

            Text(
                "Use your global keyboard shortcut to open JAM from anywhere on your Mac."
            )
            .font(.title3)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: 500)

            Spacer()

        }

    }

    private var launchAtLoginPage: some View {

        VStack(spacing: 24) {

            Spacer()

            Image(systemName: "power")
                .font(.system(size: 52))

            Text("Ready when your Mac starts.")
                .font(.largeTitle.bold())

            Text(
                "JAM can launch automatically when you log in, so it is always available."
            )
            .font(.title3)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: 500)

            Spacer()

        }

    }

    private var readyPage: some View {

        VStack(spacing: 24) {

            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 58))

            Text("JAM is ready.")
                .font(.largeTitle.bold())

            Text(
                "Search your Mac, open applications, find files, and run commands from one place."
            )
            .font(.title3)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: 500)

            Spacer()

        }

    }

    // MARK: - Navigation

    private var navigationBar: some View {

        HStack {

            if currentStep > 0 {

                Button("Back") {

                    currentStep -= 1

                }

            }

            Spacer()

            Text("\(currentStep + 1) of \(finalStep + 1)")
                .font(.caption)
                .foregroundStyle(.secondary)

            Spacer()

            Button(
                currentStep == finalStep
                    ? "Start Using JAM"
                    : "Continue"
            ) {

                if currentStep < finalStep {

                    currentStep += 1

                } else {

                    JAMApplication.shared.completeOnboarding()

                }
            }
            .buttonStyle(.borderedProminent)

        }

    }

}
