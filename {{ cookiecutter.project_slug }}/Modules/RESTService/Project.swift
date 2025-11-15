import ProjectDescription
import ProjectDescriptionHelpers

let module = Module(
    name: "RESTService",
    targets: [
        Module.Target(
            name: "RESTService",
            destinations: .appDestinations,
            type: .library,
            dependencies: [
                .local(module: "LoggingService", target: "LoggingService"),
                .package(product: "DependencyInjection", package: .dependencyInjection),
            ]
        ),
    ]
)

let project = Project(module)
