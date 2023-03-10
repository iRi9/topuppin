//
//  PromotionCollectionViewCell.swift
//  Topuppin
//
//  Created by Giri Bahari on 18/02/23.
//

import UIKit

class PromotionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imgvPromo: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewContent.layer.cornerRadius = 4
        viewContent.layer.borderWidth = 2
        viewContent.layer.borderColor = UIColor.systemGray6.cgColor
        imgvPromo.layer.cornerRadius = 4
    }

    func configure(with promo: Promo) {
        imgvPromo.image = UIImage(named: promo.image)
    }

}
