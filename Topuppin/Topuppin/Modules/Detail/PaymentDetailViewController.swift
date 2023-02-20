//
//  PaymentDetailViewController.swift
//  Topuppin
//
//  Created by Giri Bahari on 20/02/23.
//

import UIKit

class PaymentDetailViewController: UIViewController {

    var loanData: ConfirmationModel!

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnOk: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Payment Details"
        setupCollectionView()
    }

    @IBAction func didTapCloseBtn(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func didTapOkBtn(_ sender: UIButton) {
        
        performSegue(withIdentifier: "gohome", sender: nil)
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(OrderDetailCollectionViewCell.nib,
                                forCellWithReuseIdentifier: OrderDetailCollectionViewCell.identifier)
        collectionView.register(PaymentDetailsCollectionViewCell.nib,
                                forCellWithReuseIdentifier: PaymentDetailsCollectionViewCell.identifier)
        collectionView.register(InfoCollectionViewCell.nib,
                                forCellWithReuseIdentifier: InfoCollectionViewCell.identifier)

        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0: return PaymentLayout.shared.orderSection()
            case 1: return PaymentLayout.shared.paymentSection()
            case 2: return PaymentLayout.shared.infoSection()
            default: fatalError("Layout not configured")
            }

        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}

// MARK: UICollectionViewDelegate -
extension PaymentDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: OrderDetailCollectionViewCell.identifier,
                for: indexPath) as! OrderDetailCollectionViewCell

            cell.configure(with: loanData)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PaymentDetailsCollectionViewCell.identifier,
                for: indexPath) as! PaymentDetailsCollectionViewCell
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: InfoCollectionViewCell.identifier,
                for: indexPath) as! InfoCollectionViewCell
            let info = "Invoice has been emailed to you\nHave problem? Email us at support@kredivo.com"
            cell.configure(info: info, for: .secondary)
            return cell
        default: fatalError("Cell not configured")
        }
    }
}
