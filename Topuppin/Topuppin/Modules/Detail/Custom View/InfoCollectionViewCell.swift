//
//  InfoCollectionViewCell.swift
//  Topuppin
//
//  Created by Giri Bahari on 19/02/23.
//

import UIKit

enum InfoType {
    case primary
    case secondary
}

class InfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lblInfo: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 6
    }

    func configure(info: String, for type: InfoType = .primary) {
        lblInfo.text = info
        switch type {
        case .primary:
            cardView.backgroundColor = UIColor(named: "InfoColor")!
            lblInfo.font = .boldSystemFont(ofSize: 12)
            lblInfo.textColor = .black
        case .secondary:
            cardView.backgroundColor = UIColor(named: "HeaderColor")!
            lblInfo.font = .systemFont(ofSize: 12)
            lblInfo.textColor = .darkGray
        }
    }
}
