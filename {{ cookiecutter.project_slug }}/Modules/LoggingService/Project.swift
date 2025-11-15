import ProjectDescription
import ProjectDescriptionHelpers

let module = Module(
    name: "LoggingService",
    targets: [
        Module.Target(
            name: "LoggingService",
            destinations: .appDestinations,
            type: .library,
            dependencies: [
                .external(target: "Logging"),
            ]
        ),
    ]
)

let project = Project(module)
