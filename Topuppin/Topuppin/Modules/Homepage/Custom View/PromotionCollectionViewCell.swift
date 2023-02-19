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
        imgvPromo.layer.cornerRadius = 4
    }

    func configure(with promo: Promo) {
        imgvPromo.image = UIImage(named: promo.image)
    }

}
