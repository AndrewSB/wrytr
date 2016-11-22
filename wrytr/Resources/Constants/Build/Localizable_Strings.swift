// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable type_body_length
enum L10n {
  /// It seems as if you cancelled the facebook login? Try again.
  case AuthErrorFacebookCancelled
  /// There was an error authenticating with Facebook, Try signing in again.
  case AuthErrorFacebookGeneric
  /// Create
  case CreateTitle
  /// Feed
  case FeedTitle
  /// %@ with Email
  case LoginLandingEmailbuttonTitle(String)
  /// Haven't registered yet?
  case LoginLandingHelperLoginTitle
  /// Already registered?
  case LoginLandingHelperRegisterTitle
  /// Log in
  case LoginLandingLoginTitle
  /// Sign up
  case LoginLandingRegisterTitle
  /// Continue with social
  case LoginLandingSocialButtonTitle
  /// Use your words
  case LoginLandingSubtitle
  /// Me
  case MeTitle
}
// swiftlint:enable type_body_length

extension L10n: CustomStringConvertible {
  var description: String { return self.string }

  var string: String {
    switch self {
      case .AuthErrorFacebookCancelled:
        return L10n.tr(key: "auth.error.facebook.cancelled")
      case .AuthErrorFacebookGeneric:
        return L10n.tr(key: "auth.error.facebook.generic")
      case .CreateTitle:
        return L10n.tr(key: "create.title")
      case .FeedTitle:
        return L10n.tr(key: "feed.title")
      case .LoginLandingEmailbuttonTitle(let p0):
        return L10n.tr(key: "login.landing.emailbutton.title", p0)
      case .LoginLandingHelperLoginTitle:
        return L10n.tr(key: "login.landing.helper.login.title")
      case .LoginLandingHelperRegisterTitle:
        return L10n.tr(key: "login.landing.helper.register.title")
      case .LoginLandingLoginTitle:
        return L10n.tr(key: "login.landing.login.title")
      case .LoginLandingRegisterTitle:
        return L10n.tr(key: "login.landing.register.title")
      case .LoginLandingSocialButtonTitle:
        return L10n.tr(key: "login.landing.socialButton.title")
      case .LoginLandingSubtitle:
        return L10n.tr(key: "login.landing.subtitle")
      case .MeTitle:
        return L10n.tr(key: "me.title")
    }
  }

  private static func tr(key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

func tr(key: L10n) -> String {
  return key.string
}
