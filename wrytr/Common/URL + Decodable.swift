import Himotoki

let URLTransformer = Transformer<String, URL> { URLString throws -> URL in
    if let URL = URL(string: URLString) {
        return URL
    }
    
    throw customError("Invalid URL string: \(URLString)")
}
