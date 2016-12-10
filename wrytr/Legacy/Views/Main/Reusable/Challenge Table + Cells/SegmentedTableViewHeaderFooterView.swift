import UIKit
import Then

class SegmentedTableViewHeaderFooterView: UITableViewHeaderFooterView {
    let segmentedControl = UISegmentedControl()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
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
        segmentedControl.frame = self.frame
    }
}
