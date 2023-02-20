//
//  HeaderPromoCollectionReusableView.swift
//  Topuppin
//
//  Created by Giri Bahari on 18/02/23.
//

import UIKit

class HeaderPromoCollectionReusableView: UICollectionReusableView {
    lazy var headerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(lblTitle)
        lblTitle.leadingAnchor.constraint(equalTo: v.leadingAnchor).isActive = true
        lblTitle.topAnchor.constraint(equalTo: v.topAnchor).isActive = true
        lblTitle.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true

        return v
    }()

    lazy private var lblTitle: UILabel = {
        let l = UILabel()
        l.font = .boldSystemFont(ofSize: 14)
        l.text = "Promos"
        l.translatesAutoresizingMaskIntoConstraints = false

        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerView)
        setUpConstrains()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func changeFooter(color: UIColor) {
        headerView.backgroundColor = color
    }

    private func setUpConstrains(){
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 32),
            headerView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
