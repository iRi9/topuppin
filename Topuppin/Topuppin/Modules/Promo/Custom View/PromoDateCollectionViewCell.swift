//
//  PromoDateCollectionViewCell.swift
//  Topuppin
//
//  Created by Giri Bahari on 20/02/23.
//

import UIKit

class PromoDateCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with promo: Promo) {
        lblDate.text = promo.promoPeriod
    }
}
