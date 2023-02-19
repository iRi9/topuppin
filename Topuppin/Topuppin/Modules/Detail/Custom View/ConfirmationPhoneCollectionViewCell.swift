//
//  ConfirmationPhoneCollectionViewCell.swift
//  Topuppin
//
//  Created by Giri Bahari on 19/02/23.
//

import UIKit

class ConfirmationPhoneCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var viewSeparator: UIView!
    @IBOutlet weak var imgvProvider: UIImageView!
    @IBOutlet weak var lblPhoneNumber: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewSeparator.backgroundColor = .systemGray6
        viewSeparator.alpha = 0.4
    }

    func configure(with phoneModel: ConfirmationModel) {
        lblPhoneNumber.text = phoneModel.phoneNumber
        if let providerImgName = phoneModel.providerImage {
            imgvProvider.image = UIImage(named: providerImgName)
        }
    }

}
