//
//  PhoneNumberCollectionViewCell.swift
//  Topuppin
//
//  Created by Giri Bahari on 18/02/23.
//

import UIKit

protocol PhoneNumberCellDelegate {
    func didTapContact()
    func getPhoneNumber(_ phoneNumber: String?)
}

struct PhoneNumberModel: Decodable {
    var number: String
    var providerImage: String?
}

class PhoneNumberCollectionViewCell: UICollectionViewCell {

    var delegate: PhoneNumberCellDelegate?

    @IBOutlet weak var viewProvider: UIView!
    @IBOutlet weak var imgvProvider: UIImageView!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var btnContact: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewProvider.clipsToBounds = true
        viewProvider.layer.cornerRadius = viewProvider.bounds.width * 0.5
        viewProvider.layer.borderWidth = 1
        viewProvider.layer.borderColor = UIColor(named: "PrimaryColor")!.cgColor
        tfPhoneNumber.inputAccessoryView = createInputAccessoryView()
    }

    func configure(with phoneModel: PhoneNumberModel) {
        tfPhoneNumber.text = phoneModel.number
        if let providerImgName = phoneModel.providerImage {
            imgvProvider.image = UIImage(named: providerImgName)
        }
    }

    @IBAction func didTapClear(_ sender: Any) {
        tfPhoneNumber.text = nil
        delegate?.getPhoneNumber(tfPhoneNumber.text)
    }

    @IBAction func didTapContact(_ sender: Any) {
        delegate?.didTapContact()
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
        tfPhoneNumber.endEditing(true)
        delegate?.getPhoneNumber(tfPhoneNumber.text)
    }

}
