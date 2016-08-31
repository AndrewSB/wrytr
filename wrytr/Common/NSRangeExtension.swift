import Foundation

extension NSRange {
    
    init(ofString: String, inString: String) {
        self = NSString(string: inString).range(of: ofString)
    }
    
    static func rangeGenerator(withString inString: String) -> ((String) -> NSRange) {
        
        return { (ofString: String) -> NSRange in
            return NSRange(ofString: ofString, inString: inString)
        }
    }
    
}
