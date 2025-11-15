import Foundation

enum Environment {
    private static var environment: [String: String] {
        ProcessInfo.processInfo.environment
    }

    static var debug: Bool {
        environment["TUIST_DEBUG"] == "true"
    }
}
