//
//  TabItemView.swift
//  Topuppin
//
//  Created by Giri Bahari on 22/02/23.
//

import UIKit

class TabItemView: UIView, TabItemProtocol {

    private let title: String

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(title: String) {
        self.title = title
        super.init(frame: .zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = .white
        self.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    func onSelected() {
        self.titleLabel.font = .boldSystemFont(ofSize: 14)
        self.titleLabel.textColor = UIColor(named: "SecondaryColor")!
        self.borderView.backgroundColor = UIColor(named: "SecondaryColor")!
        self.addSubview(borderView)
        NSLayoutConstraint.activate([
            borderView.leftAnchor.constraint(equalTo: self.leftAnchor),
            borderView.rightAnchor.constraint(equalTo: self.rightAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 5),
            borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

    }

    func onNotSelected() {
        self.titleLabel.font = .systemFont(ofSize: 14)
        self.titleLabel.textColor = .darkGray
        self.layer.shadowOpacity = 0
        self.borderView.removeFromSuperview()
    }

}
