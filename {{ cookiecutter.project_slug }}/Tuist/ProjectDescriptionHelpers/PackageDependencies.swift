import ProjectDescription

public extension Package {
    static var afluent: Package {
        return .package(url: "https://github.com/Tyler-Keith-Thompson/Afluent.git", from: "0.6.0")
    }

    static var dependencyInjection: Package {
        return .package(url: "https://github.com/Tyler-Keith-Thompson/DependencyInjection.git", from: "0.0.15")
    }
}
