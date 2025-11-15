import Foundation

public extension URLRequest {
    func withJSONData(_ data: Data) -> Self {
        var copy = self
        copy.httpBody = data
        copy.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return copy
    }
}
