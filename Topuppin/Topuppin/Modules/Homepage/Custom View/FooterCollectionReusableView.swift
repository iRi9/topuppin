//
//  FooterCollectionReusableView.swift
//  Topuppin
//
//  Created by Giri Bahari on 18/02/23.
//

import UIKit

class FooterCollectionReusableView: UICollectionReusableView {

    lazy var footer: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(named: "FooterColor")!
        return v
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(footer)
        setUpConstrains()
    }

    func changeFooter(color: UIColor) {
        footer.backgroundColor = color
    }

    private func setUpConstrains(){
        NSLayoutConstraint.activate([
            footer.leadingAnchor.constraint(equalTo: leadingAnchor),
            footer.trailingAnchor.constraint(equalTo: trailingAnchor),
            footer.heightAnchor.constraint(equalToConstant: 8),
            footer.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UICollectionReusableView {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
