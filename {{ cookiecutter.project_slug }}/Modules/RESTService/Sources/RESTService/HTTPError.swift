public protocol HTTPError: Error {
    var statusCode: UInt { get }
}

public struct HTTPClientError: HTTPError {
    public var statusCode: UInt
}

public struct HTTPServerError: HTTPError {
    public var statusCode: UInt
}

public struct HTTPInvalidError: HTTPError {
    public var statusCode: UInt
}
