//
//  NominalCollectionViewCell.swift
//  Topuppin
//
//  Created by Giri Bahari on 18/02/23.
//

import UIKit

struct NominalModel: Decodable {
    let title: String
    let subtitle: String
    let buttonTitle: String
}

class NominalCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var btnNominal: UIButton!
    @IBOutlet weak var viewSeparator: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        btnNominal.layer.cornerRadius = 4
    }

    func configure(with nominal: NominalModel) {
        lblTitle.text = nominal.title
        lblSubtitle.text = nominal.subtitle
        btnNominal.setTitle(nominal.buttonTitle, for: .normal)
    }

    func hideSeparator(_ state: Bool = false) {
        viewSeparator.isHidden = state
    }

}
