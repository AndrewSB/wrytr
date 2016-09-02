import UIKit
import Library
import RxSwift
import RxCocoa

extension Landing {
   
    class UI: UIType {
        let interface: Landing.ViewController.IB
        let handler = Landing.Handler()
        
        lazy var bindings: [Disposable] = [
            self.interface.facebookButton.rx.tap.asDriver().drive(onNext: self.handler.facebookTap),
            self.interface.twitterButton.rx.tap.asDriver().drive(onNext: self.handler.twitterTap)
        ]
        
        init(interface: Landing.ViewController.IB) {
            self.interface = {
                $0.formContainer.addEdgePadding()
                
                $0.subtitle.text = tr(key: .LoginLandingSubtitle)
                
                $0.twitterButton.configure(withColor: UIColor(named: .TwitterBlue))
                $0.facebookButton.configure(withColor: UIColor(named: .FacebookBlue))
                
                [$0.usernameField, $0.emailField, $0.passwordField].forEach { field in field.configure() }
                
                $0.termsOfServiceButton.attributize()
                
                $0.helperButton.layer.borderColor = UIColor(named: .LoginLandingBackround).cgColor
                $0.helperButton.layer.borderWidth = 1
                
                return $0
            }(interface)
        }
    }
    
}

fileprivate extension UIButton {
    fileprivate func configure(withColor color: UIColor) {
        let renderedImage = self.imageView!.image!.withRenderingMode(.alwaysTemplate)
        self.setImage(renderedImage, for: .normal)
        self.imageView!.contentMode = .scaleAspectFit
        
        self.tintColor = color
        
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }
    
    fileprivate func attributize() {
        let title = self.titleLabel!.text!
        let range = NSRange.init(ofString: "Terms & Privacy Policy", inString: title)
        
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttributes([NSForegroundColorAttributeName: UIColor(named: .LoginLandingBackround)], range: range)
        self.setAttributedTitle(attributedString, for: .normal)
        
        self.titleLabel!.lineBreakMode = .byWordWrapping
    }
}

fileprivate extension InsettableTextField {
    fileprivate func configure() {
        insetX = 8
        insetY = 5
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        
        layer.cornerRadius = 4
        clipsToBounds = true
    }
}
