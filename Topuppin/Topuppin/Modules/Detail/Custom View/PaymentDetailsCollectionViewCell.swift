//
//  PaymentDetailsCollectionViewCell.swift
//  Topuppin
//
//  Created by Giri Bahari on 19/02/23.
//

import UIKit

class PaymentDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblAdminPrice: UILabel!
    @IBOutlet weak var viewDotted: UIView!
    @IBOutlet weak var lblTotal: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewCard.layer.cornerRadius = 6
        viewCard.layer.borderColor = UIColor.systemGray6.cgColor
        viewCard.layer.borderWidth = 1
        viewHeader.layer.cornerRadius = 6
        viewHeader.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        viewDotted.makeDashedBorderLine(color: .black, strokeLength: 7, gapLength: 5, width: 1)
    }

}
