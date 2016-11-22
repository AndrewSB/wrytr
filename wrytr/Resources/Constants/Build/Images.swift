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
  case comment = "comment"
  case facebookLogo = "facebook-logo"
  case arrowLeft = "arrow-left"
  case elipses = "elipses"
  case iIcon = "i-icon"
  case share = "share"
  case star = "star"
  case iconTabbarCreate = "icon-tabbar-create"
  case iconTabbarFeed = "icon-tabbar-feed"
  case iconTabbarFriends = "icon-tabbar-friends"
  case iconTabbarProfile = "icon-tabbar-profile"
  case twitterLogo = "twitter-logo"
  case wrytrWorded = "wrytr-worded"

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
