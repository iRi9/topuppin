//
//  PinCollectionViewCell.swift
//  Topuppin
//
//  Created by Giri Bahari on 19/02/23.
//

import UIKit

protocol PinCellDelegate {
    func getPin(_ pin: String?)
}

class PinCollectionViewCell: UICollectionViewCell {

    var delegate: PinCellDelegate?

    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var tfPin: UITextField!
    @IBOutlet weak var btnSecret: UIButton!
    @IBOutlet weak var tvAgreement: UITextView!

    var isPinHidden = true

    override func awakeFromNib() {
        super.awakeFromNib()
        viewCard.layer.cornerRadius = 6
        viewCard.layer.borderColor = UIColor.systemGray6.cgColor
        viewCard.layer.borderWidth = 1
        viewHeader.layer.cornerRadius = 6
        viewHeader.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]

        tfPin.isSecureTextEntry = isPinHidden
        tfPin.inputAccessoryView = createInputAccessoryView()

        let agreementString = "By continuing, I agree with loan agreement of Kredivo"
        let agreementAttribute = NSMutableAttributedString(string: agreementString)
        agreementAttribute.addAttribute(.link,
                                            value: "https://example.com/loan-agreement-kredivo",
                                            range: (agreementAttribute.string as NSString)
            .range(of: "loan agreement of Kredivo"))
        tvAgreement.attributedText = agreementAttribute
        tvAgreement.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "PrimaryColor")!]
        tvAgreement.attributedText = agreementAttribute
    }

    @IBAction func didTapSecrete(_ sender: Any) {
        isPinHidden.toggle()
        tfPin.isSecureTextEntry = isPinHidden
        btnSecret.setImage(UIImage(systemName: isPinHidden ? "eye.slash" : "eye"), for: .normal)
    }

    func createInputAccessoryView() -> UIView {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        return doneToolbar
    }

    @objc
    func doneButtonAction() {
        tfPin.endEditing(true)
        delegate?.getPin(tfPin.text)
    }
}

// MARK: UITextViewDelegate -
extension PinCollectionViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView,
                  shouldInteractWith URL: URL,
                  in characterRange: NSRange,
                  interaction: UITextItemInteraction) -> Bool {
        return true
    }
}
