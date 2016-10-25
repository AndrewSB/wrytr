import UIKit
import UnderKeyboard
import RxSwift
import RxCocoa

extension Compose {

    class UI: UIType {
        weak var loaderAndErrorPresenter: (LoadingIndicatable & ErrorPresentable)?

        let interface: ComposeViewController.IB
        let characterLimit: Int

        let postCreated: Observable<String>

        fileprivate let internalDelegate = InternalDelegate()

        lazy var bindings: [Disposable] = [
            self.interface.textView.rx.textInput.text
                .subscribe(onNext: { _ in self.interface.characterCount.sizeToFit() }),
            self.interface.textView.rx.textInput.text
                .map { text in text!.characters.count }
                .map { count in
                    let countColor: UIColor = count >= self.characterLimit ? .red : .gray
                    let countString = generateAttributedString("\(count)", color: countColor)
                    let limitString = generateAttributedString("/\(self.characterLimit)", color: .black)
                    countString.append(limitString)
                    return countString
                }
                .bindTo(self.interface.characterCount.rx.attributedText)

        ]

        init(interface: ComposeViewController.IB, characterLimit: Int) {
            self.interface = interface
            self.characterLimit = characterLimit

            self.interface.textView.delegate = internalDelegate
            self.postCreated = self.internalDelegate.hitEnterSubject.asObservable()
        }
    }
}


extension Compose.UI {


    class InternalDelegate: NSObject, UITextViewDelegate {
        let hitEnterSubject = PublishSubject<String>()

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool { //swiftlint:disable:this variable_name

            if text == "\n" {
                textView.endEditing(true)
                hitEnterSubject.onNext(textView.text)
                return false
            } else {
                return true
            }

        }
    }

}

fileprivate func generateAttributedString(_ string: String, color: UIColor) -> NSMutableAttributedString {
    let attributedString = NSAttributedString(string: string, attributes: [NSForegroundColorAttributeName: color])
    
    return NSMutableAttributedString(attributedString: attributedString)
}
