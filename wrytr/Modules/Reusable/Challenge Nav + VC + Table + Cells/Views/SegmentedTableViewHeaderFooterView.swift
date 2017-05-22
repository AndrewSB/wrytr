import UIKit
import Then
import RxSwift
import RxCocoa

class SegmentedTableViewHeaderView: UIView {
    private let segmentedControl = UISegmentedControl()

    var segments: [String] = [] {
        didSet {
            segmentedControl.removeAllSegments()
            segments.enumerated().forEach { idx, title in
                segmentedControl.insertSegment(withTitle: title, at: idx, animated: false)
            }

            if let idx = selectedSegmentIndex { self.segmentedControl.selectedSegmentIndex = idx }
        }
    }
    var selectedSegmentIndex: Int? {
        didSet { selectedSegmentIndex.flatMap { self.segmentedControl.selectedSegmentIndex = $0 } }
    }

    override var tintColor: UIColor! {
        didSet {
            self.segmentedControl.tintColor = tintColor
        }
    }

    var selected: ControlProperty<Int> {
        return segmentedControl.rx.value
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        self.addSubview(segmentedControl)
    }

    override func layoutSubviews() {
        segmentedControl.frame.size.height = self.frame.size.height - (2 * (self.frame.size.height - 11)) // 11 from the top and bottom
        segmentedControl.frame.size.width = self.frame.size.width - (2 * (self.frame.size.width - 14)) // 14 from the left & right

        segmentedControl.center = self.center
    }
}
