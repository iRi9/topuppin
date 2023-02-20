//
//  InfoCollectionViewCell.swift
//  Topuppin
//
//  Created by Giri Bahari on 19/02/23.
//

import UIKit

enum InfoType {
    case primary
    case secondary
}

class InfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var tvInfo: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 6
    }

    func configure(info: String, for type: InfoType = .primary) {
        cardView.backgroundColor = UIColor(named: type == .primary ? "InfoColor" : "HeaderColor")!
        let infoAttribute = NSMutableAttributedString(string: info)
        if type == .secondary {
            infoAttribute.addAttribute(.link,
                                       value: "mailto:support@kredivo.com",
                                       range: (infoAttribute.string as NSString)
                .range(of: "support@kredivo.com"))
            tvInfo.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "PrimaryColor")!]
        }
        tvInfo.attributedText = infoAttribute
    }
}

// MARK: UITextViewDelegate -
extension InfoCollectionViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView,
                  shouldInteractWith URL: URL,
                  in characterRange: NSRange,
                  interaction: UITextItemInteraction) -> Bool {
        return true
    }
}
