// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation
import UIKit

// swiftlint:disable file_length
// swiftlint:disable line_length
// swiftlint:disable type_body_length

protocol StoryboardSceneType {
  static var storyboardName: String { get }
}

extension StoryboardSceneType {
  static func storyboard() -> UIStoryboard {
    return UIStoryboard(name: self.storyboardName, bundle: Bundle(for: BundleToken.self))
  }

  static func initialViewController() -> UIViewController {
    guard let vc = storyboard().instantiateInitialViewController() else {
      fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
    }
    return vc
  }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
  func viewController() -> UIViewController {
    return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue)
  }
  static func viewController(identifier: Self) -> UIViewController {
    return identifier.viewController()
  }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
  func perform<S: StoryboardSegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
    performSegue(withIdentifier: segue.rawValue, sender: sender)
  }
}

enum StoryboardScene {
  enum Challenge: String, StoryboardSceneType {
    static let storyboardName = "Challenge"

    static func initialViewController() -> wrytr.ChallengeNavigationController {
      guard let vc = storyboard().instantiateInitialViewController() as? wrytr.ChallengeNavigationController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }

    case challengeNavScene = "challengeNav"
    static func instantiateChallengeNav() -> wrytr.ChallengeNavigationController {
      guard let vc = StoryboardScene.Challenge.challengeNavScene.viewController() as? wrytr.ChallengeNavigationController
      else {
        fatalError("ViewController 'challengeNav' is not of the expected class wrytr.ChallengeNavigationController.")
      }
      return vc
    }

    case challengeVCScene = "challengeVC"
    static func instantiateChallengeVC() -> wrytr.ChallengeViewController {
      guard let vc = StoryboardScene.Challenge.challengeVCScene.viewController() as? wrytr.ChallengeViewController
      else {
        fatalError("ViewController 'challengeVC' is not of the expected class wrytr.ChallengeViewController.")
      }
      return vc
    }
  }
  enum Compose: String, StoryboardSceneType {
    static let storyboardName = "Compose"

    case composeScene = "compose"
    static func instantiateCompose() -> wrytr.ComposeViewController {
      guard let vc = StoryboardScene.Compose.composeScene.viewController() as? wrytr.ComposeViewController
      else {
        fatalError("ViewController 'compose' is not of the expected class wrytr.ComposeViewController.")
      }
      return vc
    }
  }
  enum Create: String, StoryboardSceneType {
    static let storyboardName = "Create"

    case createScene = "create"
    static func instantiateCreate() -> wrytr.CreateViewController {
      guard let vc = StoryboardScene.Create.createScene.viewController() as? wrytr.CreateViewController
      else {
        fatalError("ViewController 'create' is not of the expected class wrytr.CreateViewController.")
      }
      return vc
    }

    case createNavScene = "createNav"
    static func instantiateCreateNav() -> wrytr.CreateNavigationController {
      guard let vc = StoryboardScene.Create.createNavScene.viewController() as? wrytr.CreateNavigationController
      else {
        fatalError("ViewController 'createNav' is not of the expected class wrytr.CreateNavigationController.")
      }
      return vc
    }
  }
  enum Landing: String, StoryboardSceneType {
    static let storyboardName = "Landing"

    case landingScene = "Landing"
    static func instantiateLanding() -> wrytr.LandingViewController {
      guard let vc = StoryboardScene.Landing.landingScene.viewController() as? wrytr.LandingViewController
      else {
        fatalError("ViewController 'Landing' is not of the expected class wrytr.LandingViewController.")
      }
      return vc
    }
  }
  enum LaunchScreen: StoryboardSceneType {
    static let storyboardName = "LaunchScreen"
  }
  enum Me: String, StoryboardSceneType {
    static let storyboardName = "Me"

    static func initialViewController() -> wrytr.MeNavigationController {
      guard let vc = storyboard().instantiateInitialViewController() as? wrytr.MeNavigationController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }

    case meVCScene = "meVC"
    static func instantiateMeVC() -> wrytr.MeViewController {
      guard let vc = StoryboardScene.Me.meVCScene.viewController() as? wrytr.MeViewController
      else {
        fatalError("ViewController 'meVC' is not of the expected class wrytr.MeViewController.")
      }
      return vc
    }

    case navConScene = "navCon"
    static func instantiateNavCon() -> wrytr.MeNavigationController {
      guard let vc = StoryboardScene.Me.navConScene.viewController() as? wrytr.MeNavigationController
      else {
        fatalError("ViewController 'navCon' is not of the expected class wrytr.MeNavigationController.")
      }
      return vc
    }
  }
  enum PostDetail: String, StoryboardSceneType {
    static let storyboardName = "PostDetail"

    case postDetailScene = "postDetail"
    static func instantiatePostDetail() -> wrytr.PostDetailViewController {
      guard let vc = StoryboardScene.PostDetail.postDetailScene.viewController() as? wrytr.PostDetailViewController
      else {
        fatalError("ViewController 'postDetail' is not of the expected class wrytr.PostDetailViewController.")
      }
      return vc
    }
  }
  enum Profile: String, StoryboardSceneType {
    static let storyboardName = "Profile"

    case profileScene = "profile"
    static func instantiateProfile() -> wrytr.ProfileViewController {
      guard let vc = StoryboardScene.Profile.profileScene.viewController() as? wrytr.ProfileViewController
      else {
        fatalError("ViewController 'profile' is not of the expected class wrytr.ProfileViewController.")
      }
      return vc
    }
  }
  enum ProfilePhoto: String, StoryboardSceneType {
    static let storyboardName = "ProfilePhoto"

    case profilePhotoVCScene = "profilePhotoVC"
    static func instantiateProfilePhotoVC() -> wrytr.ProfilePhotoViewController {
      guard let vc = StoryboardScene.ProfilePhoto.profilePhotoVCScene.viewController() as? wrytr.ProfilePhotoViewController
      else {
        fatalError("ViewController 'profilePhotoVC' is not of the expected class wrytr.ProfilePhotoViewController.")
      }
      return vc
    }
  }
  enum Startup: StoryboardSceneType {
    static let storyboardName = "Startup"

    static func initialViewController() -> wrytr.StartupViewController {
      guard let vc = storyboard().instantiateInitialViewController() as? wrytr.StartupViewController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }
  }
}

enum StoryboardSegue {
  enum Me: String, StoryboardSegueType {
    case embedProfilePhoto
  }
}

private final class BundleToken {}
