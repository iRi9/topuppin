//
//  HeaderPromoCollectionViewCell.swift
//  Topuppin
//
//  Created by Giri Bahari on 20/02/23.
//

import UIKit

class HeaderPromoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgvPromo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func configure(with promo: Promo) {
        imgvPromo.image = UIImage(named: promo.image)
        lblTitle.text = promo.title
    }

}
