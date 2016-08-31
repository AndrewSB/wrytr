import Foundation

typealias UserID = String

protocol UserType {
    var id: UserID { get }
    var name: String { get }
    var photo: URL? { get }
}
