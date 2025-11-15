import OSLog

public func startLogging() {
    Logger.logDate = Date()
}

public func printLogs() {
    if Environment.debug {
        do {
            try Logger.printLogs()
        } catch {
            Logger.logger.error("Failed to print logs: \(error)")
        }
    }
}

extension Logger {
    static let logger = Logger(subsystem: bundleID(name: "ProjectDescriptionHelpers"), category: "generate")

    fileprivate static var logDate = Date()

    fileprivate static func printLogs() throws {
        let localStore = try OSLogStore(scope: .currentProcessIdentifier)
        let position = localStore.position(date: logDate)
        let entries = try localStore.getEntries(at: position)
        for entry in entries {
            print("\(entry.date.ISO8601Format()) \(entry.composedMessage)")
        }
    }
}
