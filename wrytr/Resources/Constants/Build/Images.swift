// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  typealias Image = UIImage
#elseif os(OSX)
  import AppKit.NSImage
  typealias Image = NSImage
#endif

// swiftlint:disable file_length
// swiftlint:disable line_length

// swiftlint:disable type_body_length
enum Asset: String {
  case Comment = "comment"
  case Facebook_Logo = "facebook-logo"
  case Arrow_Left = "arrow-left"
  case Elipses = "elipses"
  case I_Icon = "i-icon"
  case Share = "share"
  case Star = "star"
  case Icon_Tabbar_Create = "icon-tabbar-create"
  case Icon_Tabbar_Feed = "icon-tabbar-feed"
  case Icon_Tabbar_Friends = "icon-tabbar-friends"
  case Icon_Tabbar_Profile = "icon-tabbar-profile"
  case Twitter_Logo = "twitter-logo"
  case Wrytr_Worded = "wrytr-worded"

  var image: Image {
    return Image(asset: self)
  }
}
// swiftlint:enable type_body_length

extension Image {
  convenience init!(asset: Asset) {
    self.init(named: asset.rawValue)
  }
}
