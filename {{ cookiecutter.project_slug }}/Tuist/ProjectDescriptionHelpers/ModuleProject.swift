import ProjectDescription

public struct Module: Sendable {
    public init(name: String, targets: [Target]) {
        self.name = name
        self.targets = targets
    }

    let name: String
    let targets: [Target]

    var tuistPackages: [ProjectDescription.Package] {
        targets.flatMap { target in
            target.dependencies.compactMap { dependency in
                switch dependency {
                case let .package(product, package):
                    return package
                default:
                    return nil
                }
            }
        }
    }

    var tuistTargets: [ProjectDescription.Target] {
        targets.map { target in
            .target(
                name: target.name,
                destinations: target.destinations,
                product: target.type.tuistProduct,
                bundleId: bundleID(name: name),
                deploymentTargets: .appDeploymentTargets,
                infoPlist: target.infoPlist,
                sources: [
                    target.type == .unitTests ? "Tests/\(target.name)/**/*.swift" : "Sources/\(target.name)/**/*.swift",
                ],
                dependencies: target.dependencies.map(\.tuistDependency)
            )
        }
    }

    public struct Target: Sendable {
        public init(name: String, destinations: Destinations, type: TargetType, dependencies: [Dependency] = []) {
            self.name = name
            self.destinations = destinations
            self.type = type
            self.dependencies = dependencies
        }

        let name: String
        let destinations: Destinations
        let type: TargetType
        let dependencies: [Dependency]

        var infoPlist: InfoPlist {
            if type == .app {
                .extendingDefault(
                    with: [
                        "UILaunchScreen": [
                            "UIColorName": "",
                            "UIImageName": "",
                        ],
                    ]
                )
            } else {
                .default
            }
        }
    }

    public enum Dependency: Sendable {
        case target(name: String)
        case local(module: String, target: String)
        case external(target: String)
        case package(product: String, package: ProjectDescription.Package)

        var tuistDependency: ProjectDescription.TargetDependency {
            switch self {
            case let .target(target):
                return .target(name: target)
            case let .local(module, target):
                return .project(target: target, path: .relativeToRoot("Modules/\(module)"))
            case let .external(target):
                return .external(name: target)
            case let .package(product, _):
                return .package(product: product)
            }
        }
    }

    public enum TargetType: Sendable {
        case executable
        case app
        case library
        case unitTests

        var tuistProduct: ProjectDescription.Product {
            switch self {
            case .executable:
                return .commandLineTool
            case .app:
                return .app
            case .library:
                return .staticLibrary
            case .unitTests:
                return .unitTests
            }
        }
    }
}

public extension Project {
    init(_ module: Module) {
        self = Project(
            name: module.name,
            packages: module.tuistPackages,
            targets: module.tuistTargets
        )
    }
}
