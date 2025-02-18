extension ElementAssertion {
    public static func equal<T: UITestEquatable>(to value: T) -> ElementAssertion {
        return .init(name: "equal(to: \(value))", assertion: { element in
            return element.values.contains(where: { elementValue in
                return value.stringValues.contains(where: { $0.lowercased() == elementValue.lowercased() })
            })
        })
    }
}

public protocol UITestEquatable {
    var stringValues: [String] { get }
}

extension Bool: UITestEquatable {
    public var stringValues: [String] {
        switch self {
        case true: return ["1"]
        case false: return ["0"]
        }
    }
}

extension UITestEquatable where Self: LosslessStringConvertible {
    public var stringValues: [String] { return [description] }
}
extension Int: UITestEquatable { }
extension Double: UITestEquatable { }
extension String: UITestEquatable { }
