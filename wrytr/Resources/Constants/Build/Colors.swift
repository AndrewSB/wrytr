// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  typealias Color = UIColor
#elseif os(OSX)
  import AppKit.NSColor
  typealias Color = NSColor
#endif

extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}

// swiftlint:disable file_length
// swiftlint:disable line_length

// swiftlint:disable type_body_length
enum ColorName {
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#2bacb5"></span>
  /// Alpha: 100% <br/> (0x2bacb5ff)
  case CreateBackground
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#39579a"></span>
  /// Alpha: 100% <br/> (0x39579aff)
  case FacebookBlue
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#2bacb5"></span>
  /// Alpha: 100% <br/> (0x2bacb5ff)
  case LoginLandingBackround
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#3798cb"></span>
  /// Alpha: 100% <br/> (0x3798cbff)
  case LoginLoginBackground
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#53bfa8"></span>
  /// Alpha: 100% <br/> (0x53bfa8ff)
  case LoginSignupBackground
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#50abf1"></span>
  /// Alpha: 100% <br/> (0x50abf1ff)
  case TwitterBlue

  var rgbaValue: UInt32 {
    switch self {
    case .CreateBackground: return 0x2bacb5ff
    case .FacebookBlue: return 0x39579aff
    case .LoginLandingBackround: return 0x2bacb5ff
    case .LoginLoginBackground: return 0x3798cbff
    case .LoginSignupBackground: return 0x53bfa8ff
    case .TwitterBlue: return 0x50abf1ff
    }
  }

  var color: Color {
    return Color(named: self)
  }
}
// swiftlint:enable type_body_length

extension Color {
  convenience init(named name: ColorName) {
    self.init(rgbaValue: name.rgbaValue)
  }
}
