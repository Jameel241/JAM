import Foundation
import AppKit

struct SettingsEnvironment {

    static let current = SettingsEnvironment()

    let operatingSystemVersion: OperatingSystemVersion

    let hasBattery: Bool

    let hasTouchID: Bool

    let isAppleSilicon: Bool

    private init() {

        operatingSystemVersion =
            ProcessInfo.processInfo.operatingSystemVersion

        hasBattery =
            Self.detectBattery()

        hasTouchID =
            Self.detectTouchID()

        isAppleSilicon =
            Self.detectAppleSilicon()
    }


    // MARK: - macOS Version


    func isRunning(
        macOSMajorVersion version: Int
    ) -> Bool {

        operatingSystemVersion.majorVersion >= version
    }


    // MARK: - Battery


    private static func detectBattery() -> Bool {

        let task = Process()

        task.executableURL = URL(
            fileURLWithPath: "/usr/bin/pmset"
        )

        task.arguments = [
            "-g",
            "batt"
        ]

        let pipe = Pipe()

        task.standardOutput = pipe
        task.standardError = Pipe()

        do {

            try task.run()

            task.waitUntilExit()

            let data =
                pipe.fileHandleForReading
                    .readDataToEndOfFile()

            guard let output = String(
                data: data,
                encoding: .utf8
            ) else {
                return false
            }

            return output.localizedCaseInsensitiveContains(
                "InternalBattery"
            )

        } catch {

            return false
        }
    }


    // MARK: - Touch ID


    private static func detectTouchID() -> Bool {

        let task = Process()

        task.executableURL = URL(
            fileURLWithPath: "/usr/sbin/ioreg"
        )

        task.arguments = [
            "-l",
            "-r",
            "-c",
            "AppleBiometricSensor"
        ]

        let pipe = Pipe()

        task.standardOutput = pipe
        task.standardError = Pipe()

        do {

            try task.run()
            task.waitUntilExit()

            let data =
                pipe.fileHandleForReading
                    .readDataToEndOfFile()

            guard let output = String(
                data: data,
                encoding: .utf8
            ) else {
                return false
            }

            return !output
                .trimmingCharacters(
                    in: .whitespacesAndNewlines
                )
                .isEmpty

        } catch {

            return false
        }
    }

    // MARK: - Apple Silicon


    private static func detectAppleSilicon() -> Bool {

        #if arch(arm64)
        return true
        #else
        return false
        #endif
    }
}//
//  SettingsEnvironment.swift
//  JAM
//
//  Created by Jameel Iqbal on 05/07/26.
//

