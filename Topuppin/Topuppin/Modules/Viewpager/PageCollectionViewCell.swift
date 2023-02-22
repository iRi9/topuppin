//
//  PageCollectionViewCell.swift
//  Topuppin
//
//  Created by Giri Bahari on 22/02/23.
//

import UIKit

class PageCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var view: UIViewController? {
        didSet {
            self.setupUI()
        }
    }

    private func setupUI() {
        guard let vc = view else { return }

        self.contentView.addSubview(vc.view)
        vc.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            vc.view.leftAnchor
                .constraint(equalTo: self.contentView.leftAnchor),
            vc.view.topAnchor
                .constraint(equalTo: self.contentView.topAnchor),
            vc.view.rightAnchor
                .constraint(equalTo: self.contentView.rightAnchor),
            vc.view.bottomAnchor
                .constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}
