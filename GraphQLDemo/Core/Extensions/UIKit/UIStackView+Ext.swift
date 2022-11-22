import UIKit

extension UIStackView {
    func setup(axis: NSLayoutConstraint.Axis = .vertical,
               alignment: Alignment = .fill,
               distribution: Distribution = .fill,
               spacing: CGFloat = 0) {
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }

    func removeAllViews() {
        arrangedSubviews.forEach {
            removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }

    func addSpacer(_ size: CGFloat? = nil) {
        let spacer = UIView()
        spacer.backgroundColor = .clear
        addArranged(spacer, size: size)
    }

    func addArranged(_ view: UIView, size: CGFloat? = nil) {
        addArrangedSubview(view)
        guard let size = size else {
            return
        }
        switch axis {
        case .vertical:     view.heightAnchor.constraint(equalToConstant: size).isActive = true
        case .horizontal:   view.widthAnchor.constraint(equalToConstant: size).isActive = true
        default: return
        }
    }
    
    func addArranged(_ view: UIView, width: CGFloat? = nil, height: CGFloat? = nil) {
        addArrangedSubview(view)
        if let width = width {
            view.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            view.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

    func addCentered(_ view: UIView, inset: CGFloat, size: CGFloat? = nil) {
        let stack = UIStackView()
        switch axis {
        case .vertical:     stack.setup(axis: .horizontal, alignment: .fill, distribution: .fill, spacing: 0)
        case .horizontal:   stack.setup(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 0)
        default: return
        }
        stack.addSpacer(inset)
        stack.addArranged(view)
        stack.addSpacer(inset)
        addArranged(stack, size: size)
    }
    
    func addCentered(_ view: UIView, width: CGFloat, height: CGFloat) {
        let stack = UIStackView()
        switch axis {
        case .vertical:     stack.setup(axis: .horizontal, alignment: .fill, distribution: .fill, spacing: 0)
        case .horizontal:   stack.setup(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 0)
        default: return
        }
        let spacer1 = UIView()
        spacer1.backgroundColor = .clear
        let spacer2 = UIView()
        spacer2.backgroundColor = .clear
        stack.addArranged(spacer1)
        stack.addArranged(view, width: width, height: height)
        stack.addArranged(spacer2)
        spacer1.widthAnchor.constraint(equalTo: spacer2.widthAnchor).isActive = true
        addArranged(stack)
    }
}
