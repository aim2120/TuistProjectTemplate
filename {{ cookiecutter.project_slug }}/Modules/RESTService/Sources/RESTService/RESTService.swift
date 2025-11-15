import DependencyInjection
import Foundation
import Logging
import LoggingService

public extension Container {
    static let restService = Factory {
        ProdRESTService() as any RESTService
    }
}

public protocol RESTService {
    init(logger: Logger)
    var logger: Logger { get set }
    func get(_ url: URL, transform: (URLRequest) throws -> URLRequest) async throws -> (response: HTTPURLResponse, data: Data)
    func post(_ url: URL, transform: (URLRequest) throws -> URLRequest) async throws -> (response: HTTPURLResponse, data: Data)
    func delete(_ url: URL, transform: (URLRequest) throws -> URLRequest) async throws -> (response: HTTPURLResponse, data: Data)
}

public extension RESTService {
    func get(_ url: URL) async throws -> (response: HTTPURLResponse, data: Data) {
        try await get(url, transform: { $0 })
    }

    func post(_ url: URL) async throws -> (response: HTTPURLResponse, data: Data) {
        try await post(url, transform: { $0 })
    }

    func delete(_ url: URL) async throws -> (response: HTTPURLResponse, data: Data) {
        try await delete(url, transform: { $0 })
    }

    func with(logger: Logger) -> Self {
        .init(logger: logger)
    }
}

extension RESTService {
    func error(statusCode: UInt) -> HTTPError? {
        switch statusCode {
        case 200 ..< 400: return nil
        case 400 ..< 500: return HTTPClientError(statusCode: statusCode)
        case 500 ..< 600: return HTTPServerError(statusCode: statusCode)
        default: return HTTPInvalidError(statusCode: statusCode)
        }
    }
}

struct ProdRESTService {
    var logger: Logger = .init(label: String(describing: ProdRESTService.self))
    let urlSession: URLSession = .shared
}

extension ProdRESTService: RESTService {
    func get(_ url: URL, transform: (URLRequest) throws -> URLRequest) async throws -> (response: HTTPURLResponse, data: Data) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return try await perform(urlRequest: transform(request))
    }

    func post(_ url: URL, transform: (URLRequest) throws -> URLRequest) async throws -> (response: HTTPURLResponse, data: Data) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return try await perform(urlRequest: transform(request))
    }

    func delete(_ url: URL, transform: (URLRequest) throws -> URLRequest) async throws -> (response: HTTPURLResponse, data: Data) {
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        return try await perform(urlRequest: transform(request))
    }

    private func perform(urlRequest: URLRequest) async throws -> (response: HTTPURLResponse, data: Data) {
        logger.trace("\(urlRequest.debugDescription)", metadata: [
            "METHOD": .string(urlRequest.httpMethod ?? "GET"),
        ])
        let (data, response) = try await urlSession.data(for: urlRequest)
        logger.trace("\(response)")
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badURL)
        }
        if let error = error(statusCode: UInt(httpResponse.statusCode)) {
            throw error
        }
        return (httpResponse, data)
    }
}
