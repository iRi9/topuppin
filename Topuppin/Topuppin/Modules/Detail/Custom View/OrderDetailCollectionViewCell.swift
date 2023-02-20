//
//  OrderDetailCollectionViewCell.swift
//  Topuppin
//
//  Created by Giri Bahari on 19/02/23.
//

import UIKit

class OrderDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewProvider: UIView!
    @IBOutlet weak var imgvProvider: UIImageView!
    @IBOutlet weak var lblPhoneNumber: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewCard.layer.cornerRadius = 6
        viewCard.layer.borderColor = UIColor.systemGray6.cgColor
        viewCard.layer.borderWidth = 1
        viewHeader.layer.cornerRadius = 6
        viewHeader.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    func configure(with order: ConfirmationModel!) {
        lblPhoneNumber.text = order.phoneNumber
        if let providerImage = order.providerImage {
            imgvProvider.image = UIImage(named: providerImage)
        }
    }

}
