import Foundation
import ProjectDescription
import ProjectDescriptionHelpers

startLogging()

let appTargetDependencies: [TargetDependency] = modules().map { .project(target: $0.lastPathComponent, path: .relativeToRoot("Modules/\($0.lastPathComponent)")) }

let appTarget: Target = .target(
    name: "{{ cookiecutter.app_name }}",
    destinations: .appDestinations,
    product: .app,
    bundleId: bundleID,
    deploymentTargets: .appDeploymentTargets,
    infoPlist: .extendingDefault(
        with: [
            "UILaunchScreen": [
                "UIColorName": "",
                "UIImageName": "",
            ],
            "DEVELOPMENT_TEAM": "{{ cookiecutter.development_team }}",
            "NSAppTransportSecurity": [
                "NSAllowsLocalNetworking": true,
                "NSAllowsArbitraryLoads": true,
                "NSExceptionDomains": [
                    "0.0.0.0": [
                        "NSExceptionAllowsInsecureHTTPLoads": true,
                        "NSIncludesSubdomains": true,
                    ],
                ],
            ],
        ]
    ),
    sources: ["{{ cookiecutter.app_name }}/Sources/**"],
    resources: ["{{ cookiecutter.app_name }}/Resources/**"],
    dependencies: appTargetDependencies,
    settings: .settings(base: [
        "DEVELOPMENT_TEAM": "{{ cookiecutter.development_team }}",
    ])
)

let appTestTarget: Target = .target(
    name: "{{ cookiecutter.app_name }}Tests",
    destinations: .appDestinations,
    product: .unitTests,
    bundleId: bundleID(name: "{{ cookiecutter.app_name }}Tests"),
    deploymentTargets: .appDeploymentTargets,
    infoPlist: .default,
    sources: ["{{ cookiecutter.app_name }}/Tests/**"],
    resources: [],
    dependencies: [.target(name: "{{ cookiecutter.app_name }}")] + appTarget.dependencies
)

let project = Project(
    name: "{{ cookiecutter.app_name }}",
    packages: [
        // TODO: Move to Package.swift once macro build step fixed
        .afluent,
        .dependencyInjection,
    ],
    targets: [
        appTarget,
        appTestTarget,
    ],
)

printLogs()
