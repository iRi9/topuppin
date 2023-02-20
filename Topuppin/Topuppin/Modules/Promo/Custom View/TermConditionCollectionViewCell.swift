//
//  TermConditionCollectionViewCell.swift
//  Topuppin
//
//  Created by Giri Bahari on 20/02/23.
//

import UIKit

class TermConditionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTermCondition: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with termConditions: [String]) {
        let bullet = "• "
        var strings = termConditions
        strings = strings.map { return bullet + $0 }
        var attributes = [NSAttributedString.Key: Any]()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = (bullet as NSString).size(withAttributes: attributes).width
        attributes[.paragraphStyle] = paragraphStyle

        let string = strings.joined(separator: "\n\n")
        lblTermCondition.attributedText = NSAttributedString(string: string, attributes: attributes)
    }

}
