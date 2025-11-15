import Foundation
import Logging

public enum LoggingService {
    @MainActor static var bootstrapped = false

    @MainActor
    public static func boostrap() {
        guard !bootstrapped else { return }
        LoggingSystem.bootstrap { label in
            var logHandler = MultiplexLogHandler([
                StreamLogHandler.standardOutput(label: label),
            ])
            logHandler.logLevel = {
                #if RELEASE
                    .info

                #elseif DEBUG
                    .trace
                #else
                    fatalError("Unknown build mode")
                #endif
            }()
            return logHandler
        }
    }
}

@propertyWrapper
public struct Logged {
    public init(label: String) {
        logger = Logger(label: label)
    }

    public init<T>(service _: T.Type) {
        logger = Logger(label: String(describing: T.self))
    }

    private let logger: Logger

    public var wrappedValue: Logger {
        logger
    }
}
