public func print(items: Any..., separator: String = " ", terminator: String = "\n") {
    let output = items.map({ String(describing: $0) }).joined(separator: separator)
    Swift.print("bruh:" + output, terminator: terminator)
}
