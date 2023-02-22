//
//  TabCollectionViewCell.swift
//  Topuppin
//
//  Created by Giri Bahari on 22/02/23.
//

import UIKit

protocol TabItemProtocol: UIView {
    func onSelected()
    func onNotSelected()
}

class TabCollectionViewCell: UICollectionViewCell {

    public var view: TabItemProtocol? {
        didSet {
            self.setupUI()
        }
    }

    public var contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            leftConstraint.constant = contentInsets.left
            topConstraint.constant = contentInsets.top
            rightConstraint.constant = -contentInsets.right
            bottomConstraint.constant = -contentInsets.bottom
            self.contentView.layoutIfNeeded()
        }
    }

    var leftConstraint = NSLayoutConstraint()
    var topConstraint = NSLayoutConstraint()
    var rightConstraint = NSLayoutConstraint()
    var bottomConstraint = NSLayoutConstraint()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        guard let view = view else { return }

        self.contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false

        leftConstraint = view.leftAnchor
            .constraint(equalTo: self.contentView.leftAnchor,
                        constant: contentInsets.left)
        topConstraint = view.topAnchor
            .constraint(equalTo: self.contentView.topAnchor,
                        constant: contentInsets.top)
        rightConstraint = view.rightAnchor
            .constraint(equalTo: self.contentView.rightAnchor,
                        constant: -contentInsets.right)
        bottomConstraint = view.bottomAnchor
            .constraint(equalTo: self.contentView.bottomAnchor,
                        constant: -contentInsets.bottom)

        NSLayoutConstraint.activate([
            leftConstraint,
            topConstraint,
            rightConstraint,
            bottomConstraint
        ])
    }
}
