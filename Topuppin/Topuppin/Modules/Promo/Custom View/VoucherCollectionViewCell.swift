//
//  VoucherCollectionViewCell.swift
//  Topuppin
//
//  Created by Giri Bahari on 20/02/23.
//

import UIKit

protocol VoucherCellDelegate {
    func copy(text: String?)
}

class VoucherCollectionViewCell: UICollectionViewCell {

    var delegate: VoucherCellDelegate?

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewVoucher: UIView!
    @IBOutlet weak var lblVoucher: UILabel!
    @IBOutlet weak var btnCopy: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        viewVoucher.layer.cornerRadius = 6
        viewVoucher.layer.borderWidth = 1
        viewVoucher.layer.borderColor = UIColor.systemGray6.cgColor

    }

    func configure(with promo: Promo) {
        lblVoucher.text = promo.promoCode
    }

    @IBAction func didTapCopyButton(_ sender: UIButton) {
        delegate?.copy(text: lblVoucher.text)
    }

}
