//
//  PaymentDetailsCollectionViewCell.swift
//  Topuppin
//
//  Created by Giri Bahari on 19/02/23.
//

import UIKit

struct PaymentDetailModel {
    let productName: String
    let productPrice: Int
    let adminFee: Int
}

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

    func configure(with model: PaymentDetailModel) {
        lblProductName.text = model.productName
        lblProductPrice.text = Helper.shared.formatToRp(price: model.productPrice)
        lblAdminPrice.text = Helper.shared.formatToRp(price: model.adminFee)
        lblTotal.text = calculateTotalOrder(model.productPrice, model.adminFee)
    }

    private func calculateTotalOrder(_ productPrice: Int, _ adminFee: Int) -> String {
        let totalPrice = productPrice + adminFee
        return Helper.shared.formatToRp(price: totalPrice)
    }

}
