//
//  DataPackageViewController.swift
//  Topuppin
//
//  Created by Giri Bahari on 18/02/23.
//

import UIKit
import ContactsUI

protocol DataPackageaDelegate: AnyObject {
    func didSelectNominal(loanData: ConfirmationModel)
    func didSeletPromotion(promo: Promo)
}

class DataPackageViewController: UIViewController {

    weak var delegate: DataPackageaDelegate?

    @IBOutlet weak var collectionView: UICollectionView!

    var contactPicker: CNContactPickerViewController!
    var dataPackageModel: DataPackageModel!
    var phoneNumberModel: PhoneNumberModel!
    var isInputEmpty = true {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self

        dataPackageModel = loadData()
        phoneNumberModel = dataPackageModel.phone
        isInputEmpty = phoneNumberModel.number.isEmpty
        setupCollectionView()
        setupCollectionLayout()
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(HeaderPromoCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderPromoCollectionReusableView.identifier)
        collectionView.register(FooterCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: FooterCollectionReusableView.identifier)
        collectionView.register(PhoneNumberCollectionViewCell.nib,
                                forCellWithReuseIdentifier: PhoneNumberCollectionViewCell.identifier)
        collectionView.register(NominalCollectionViewCell.nib,
                                forCellWithReuseIdentifier: NominalCollectionViewCell.identifier)
        collectionView.register(PromotionCollectionViewCell.nib,
                                forCellWithReuseIdentifier: PromotionCollectionViewCell.identifier)
    }

    func loadData() -> DataPackageModel {
        guard let path = Bundle(for: type(of: self)).path(forResource: "dummy_data_package", ofType: "json") else {
            fatalError("dummy.json not found")
        }
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let dataPackageModel = try! decoder.decode(DataPackageModel.self, from: data)
        return dataPackageModel
    }

    func setupCollectionLayout() {
        var layout: UICollectionViewCompositionalLayout!
        layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0:
                return HomepageLayout.shared.inputPhoneSection()
            case 1:
                return self.isInputEmpty ? HomepageLayout.shared.promoSection() : HomepageLayout.shared.nominalSection()
            case 2:
                return HomepageLayout.shared.promoSection()
            default:
                fatalError("not configured")
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.reloadData()
    }

}

// MARK: UICollectionViewDelegate -
extension DataPackageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let totalSection = isInputEmpty ? 2 : 3
        return totalSection
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if !isInputEmpty {
            switch section {
            case 1: return dataPackageModel.packages.count
            case 2: return dataPackageModel.promos.count
            default: return 1
            }
        } else {
            switch section {
            case 1: return dataPackageModel.promos.count
            default: return 1
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PhoneNumberCollectionViewCell.identifier,
                for: indexPath) as! PhoneNumberCollectionViewCell
            cell.delegate = self
            cell.configure(with: phoneNumberModel)
            return cell
        case 1:
            if isInputEmpty {
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: PromotionCollectionViewCell.identifier,
                    for: indexPath) as! PromotionCollectionViewCell
                let promos = dataPackageModel.promos
                cell.configure(with: promos[indexPath.item])
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: NominalCollectionViewCell.identifier,
                    for: indexPath) as! NominalCollectionViewCell
                cell.delegate = self
                cell.hideSeparator(indexPath.item == dataPackageModel.packages.count - 1)
                cell.configure(with: dataPackageModel.packages[indexPath.item])
                return cell
            }
        case 2:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PromotionCollectionViewCell.identifier,
                for: indexPath) as! PromotionCollectionViewCell
            let promos = dataPackageModel.promos
            cell.configure(with: promos[indexPath.item])
            return cell
        default:
            fatalError("Not configured cellForItemAt")
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return collectionView
                .dequeueReusableSupplementaryView(ofKind: kind,
                                                  withReuseIdentifier: HeaderPromoCollectionReusableView.identifier,
                                                  for: indexPath) as! HeaderPromoCollectionReusableView
        default:
            return collectionView
                .dequeueReusableSupplementaryView(ofKind: kind,
                                                  withReuseIdentifier: FooterCollectionReusableView.identifier,
                                                  for: indexPath) as! FooterCollectionReusableView
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (isInputEmpty && indexPath.section == 1) || (!isInputEmpty && indexPath.section == 2) {
            delegate?.didSeletPromotion(promo: dataPackageModel.promos[indexPath.item])
        }
    }
}
// MARK: PhoneNumberCellDelegate -
extension DataPackageViewController: PhoneNumberCellDelegate {
    func didTapContact() {
        present(contactPicker, animated: true, completion: nil)
    }

    func getPhoneNumber(_ phoneNumber: String?) {
        phoneNumberModel.number = phoneNumber ?? ""
        isInputEmpty = !isValidPhoneNumber(phoneNumber)
    }

    func isValidPhoneNumber(_ phoneNumber: String?) -> Bool {
        let regularExpressionForPhone = "^(\\+62|62|0)8[1-9][0-9]{7,12}$"
        let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
        return testPhone.evaluate(with: phoneNumber)
    }
}

// MARK: CNContactPickerDelegate -
extension DataPackageViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let phoneNumber = contact.phoneNumbers.first?.value.stringValue ?? ""
        phoneNumberModel.number = phoneNumber.replacingOccurrences(of: " ", with: "")
        isInputEmpty = !isValidPhoneNumber(phoneNumber)
    }
}

// MARK: NominalCellDelegate -
extension DataPackageViewController: NominalCellDelegate {
    func didSelectNominal(at index: Int) {
        let dataPackage = dataPackageModel.packages[index]
        let loanData = ConfirmationModel(phoneNumber: phoneNumberModel.number,
                                         providerImage: phoneNumberModel.providerImage,
                                         order: PaymentDetailModel(productName: dataPackage.title,
                                                                   productPrice: dataPackage.buttonTitle,
                                                                   adminFee: 0))
        delegate?.didSelectNominal(loanData: loanData)
    }
}
