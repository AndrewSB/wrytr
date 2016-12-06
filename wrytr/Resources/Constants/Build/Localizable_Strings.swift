// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable line_length

// swiftlint:disable type_body_length
enum L10n {
  /// It seems as if you cancelled the facebook login? Try again.
  case authErrorFacebookCancelled
  /// There was an error authenticating with Facebook, Try signing in again.
  case authErrorFacebookGeneric
  /// Create
  case createTitle
  /// Ok
  case errorDefaultOk
  /// Feed
  case feedTitle
  /// Terms & Privacy Policy
  case loginLandingButtonTosTitleButton
  /// By signing up, you agree to our 
  case loginLandingButtonTosTitlePrefix
  /// .
  case loginLandingButtonTosTitleSuffix
  /// %@ with Email
  case loginLandingEmailbuttonTitle(String)
  /// Haven't registered yet?
  case loginLandingHelperLoginTitle
  /// Already registered?
  case loginLandingHelperRegisterTitle
  /// Log in
  case loginLandingLoginTitle
  /// Sign up
  case loginLandingRegisterTitle
  /// Continue with social
  case loginLandingSocialButtonTitle
  /// Use your words
  case loginLandingSubtitle
  /// Me
  case meTitle
}
// swiftlint:enable type_body_length

extension L10n: CustomStringConvertible {
  var description: String { return self.string }

  var string: String {
    switch self {
      case .authErrorFacebookCancelled:
        return L10n.tr(key: "auth.error.facebook.cancelled")
      case .authErrorFacebookGeneric:
        return L10n.tr(key: "auth.error.facebook.generic")
      case .createTitle:
        return L10n.tr(key: "create.title")
      case .errorDefaultOk:
        return L10n.tr(key: "error.default.ok")
      case .feedTitle:
        return L10n.tr(key: "feed.title")
      case .loginLandingButtonTosTitleButton:
        return L10n.tr(key: "login.landing.button.tos.title.button")
      case .loginLandingButtonTosTitlePrefix:
        return L10n.tr(key: "login.landing.button.tos.title.prefix")
      case .loginLandingButtonTosTitleSuffix:
        return L10n.tr(key: "login.landing.button.tos.title.suffix")
      case .loginLandingEmailbuttonTitle(let p0):
        return L10n.tr(key: "login.landing.emailbutton.title", p0)
      case .loginLandingHelperLoginTitle:
        return L10n.tr(key: "login.landing.helper.login.title")
      case .loginLandingHelperRegisterTitle:
        return L10n.tr(key: "login.landing.helper.register.title")
      case .loginLandingLoginTitle:
        return L10n.tr(key: "login.landing.login.title")
      case .loginLandingRegisterTitle:
        return L10n.tr(key: "login.landing.register.title")
      case .loginLandingSocialButtonTitle:
        return L10n.tr(key: "login.landing.socialButton.title")
      case .loginLandingSubtitle:
        return L10n.tr(key: "login.landing.subtitle")
      case .meTitle:
        return L10n.tr(key: "me.title")
    }
  }

  private static func tr(key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

func tr(_ key: L10n) -> String {
  return key.string
}
