import Argo

extension URL: Decodable {

    public static func decode(_ json: JSON) -> Decoded<URL> {
        switch json {
        case .string(let s) where URL(string: s) != nil:
            return URL(string: s).map(pure)!
        default:
            return .typeMismatch(expected: "URL", actual: json)
        }
    }

}
