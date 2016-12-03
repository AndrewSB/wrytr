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
    return UIStoryboard(name: self.storyboardName, bundle: nil)
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

struct StoryboardScene {
  enum Compose: String, StoryboardSceneType {
    static let storyboardName = "Compose"

    case composeScene = "compose"
    static func instantiateCompose() -> ComposeViewController {
      guard let vc = StoryboardScene.Compose.composeScene.viewController() as? ComposeViewController
      else {
        fatalError("ViewController 'compose' is not of the expected class ComposeViewController.")
      }
      return vc
    }
  }
  enum Create: String, StoryboardSceneType {
    static let storyboardName = "Create"

    case createScene = "create"
    static func instantiateCreate() -> CreateViewController {
      guard let vc = StoryboardScene.Create.createScene.viewController() as? CreateViewController
      else {
        fatalError("ViewController 'create' is not of the expected class CreateViewController.")
      }
      return vc
    }

    case createNavScene = "createNav"
    static func instantiateCreateNav() -> CreateNavigationController {
      guard let vc = StoryboardScene.Create.createNavScene.viewController() as? CreateNavigationController
      else {
        fatalError("ViewController 'createNav' is not of the expected class CreateNavigationController.")
      }
      return vc
    }
  }
  enum Feed: String, StoryboardSceneType {
    static let storyboardName = "Feed"

    static func initialViewController() -> FeedNavigationController {
      guard let vc = storyboard().instantiateInitialViewController() as? FeedNavigationController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }

    case feedScene = "feed"
    static func instantiateFeed() -> FeedViewController {
      guard let vc = StoryboardScene.Feed.feedScene.viewController() as? FeedViewController
      else {
        fatalError("ViewController 'feed' is not of the expected class FeedViewController.")
      }
      return vc
    }

    case feedNavScene = "feedNav"
    static func instantiateFeedNav() -> FeedNavigationController {
      guard let vc = StoryboardScene.Feed.feedNavScene.viewController() as? FeedNavigationController
      else {
        fatalError("ViewController 'feedNav' is not of the expected class FeedNavigationController.")
      }
      return vc
    }
  }
  enum Landing: String, StoryboardSceneType {
    static let storyboardName = "Landing"

    case landingScene = "Landing"
    static func instantiateLanding() -> LandingViewController {
      guard let vc = StoryboardScene.Landing.landingScene.viewController() as? LandingViewController
      else {
        fatalError("ViewController 'Landing' is not of the expected class LandingViewController.")
      }
      return vc
    }
  }
  enum LaunchScreen: StoryboardSceneType {
    static let storyboardName = "LaunchScreen"
  }
  enum Me: StoryboardSceneType {
    static let storyboardName = "Me"

    static func initialViewController() -> UINavigationController {
      guard let vc = storyboard().instantiateInitialViewController() as? UINavigationController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }
  }
  enum PostDetail: String, StoryboardSceneType {
    static let storyboardName = "PostDetail"

    case postDetailScene = "postDetail"
    static func instantiatePostDetail() -> PostDetailViewController {
      guard let vc = StoryboardScene.PostDetail.postDetailScene.viewController() as? PostDetailViewController
      else {
        fatalError("ViewController 'postDetail' is not of the expected class PostDetailViewController.")
      }
      return vc
    }
  }
  enum Startup: StoryboardSceneType {
    static let storyboardName = "Startup"

    static func initialViewController() -> StartupViewController {
      guard let vc = storyboard().instantiateInitialViewController() as? StartupViewController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }
  }
}

struct StoryboardSegue {
}