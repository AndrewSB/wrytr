import Foundation

extension Dictionary where Key == String, Value == Any {
    func embed(uid: String) -> Dictionary {
        assert(self["uid"] == nil, "we're trying to embed a UID in a reaction that already has one")

        var copy = self
        copy["uid"] = uid
        return copy
    }
}
