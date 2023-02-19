//
//  ConfirmationViewController.swift
//  Topuppin
//
//  Created by Giri Bahari on 19/02/23.
//

import UIKit

class ConfirmationViewController: UIViewController {

    var loanData: ConfirmationModel!

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnPay: UIButton!

    var pin: String?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupNavigationBarIcon()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Loan Confirmation"
        setupCollectionView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PaymentDetail",
           let pin = pin, !pin.isEmpty {
            if let navigationVC = segue.destination as? UINavigationController,
               let paymentVC = navigationVC.topViewController as? PaymentDetailViewController {
                paymentVC.loanData = loanData
            }
        }
    }


    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @IBAction func didTapPayBtn(_ sender: UIButton) {
        guard let pin = pin, !pin.isEmpty else {
            showWarningAlert(title: "Info", message: "Please input your PIN")
            return
        }
    }

    func setupNavigationBarIcon() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "PrimaryColor")
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.setBackIndicatorImage(UIImage(systemName: "arrow.left"), transitionMaskImage: UIImage(systemName: "arrow.left"))
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance

    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(ConfirmationPhoneCollectionViewCell.nib,
                                forCellWithReuseIdentifier: ConfirmationPhoneCollectionViewCell.identifier)
        collectionView.register(InfoCollectionViewCell.nib,
                                forCellWithReuseIdentifier: InfoCollectionViewCell.identifier)
        collectionView.register(PaymentDetailsCollectionViewCell.nib,
                                forCellWithReuseIdentifier: PaymentDetailsCollectionViewCell.identifier)
        collectionView.register(PinCollectionViewCell.nib, forCellWithReuseIdentifier: PinCollectionViewCell.identifier)

        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0: return ConfirmationLayout.shared.phoneSection()
            case 1: return ConfirmationLayout.shared.infoSection()
            case 2: return ConfirmationLayout.shared.paymentSection()
            case 3: return ConfirmationLayout.shared.pinSection()
            default: fatalError("Layout not configured")
            }

        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }

    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let topKeyboard = collectionView.bounds.height - keyboardSize.height
        let pinCellHeight = CGFloat(115)
        if topKeyboard > pinCellHeight {
            let yOffset = topKeyboard - pinCellHeight
            collectionView.setContentOffset(CGPoint(x: 0, y: yOffset), animated: true)
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        guard let collectionView = collectionView else { return }
        collectionView.setContentOffset(CGPoint(x: 0, y: -collectionView.adjustedContentInset.top), animated: true)
    }

}

// MARK: UICollectionViewDelegate -
extension ConfirmationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
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
                withReuseIdentifier: ConfirmationPhoneCollectionViewCell.identifier,
                for: indexPath) as! ConfirmationPhoneCollectionViewCell

            cell.configure(with: loanData)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: InfoCollectionViewCell.identifier,
                for: indexPath) as! InfoCollectionViewCell
            cell.configure(info: "OTP is not needed for first transaction of the day that less than Rp 200,000")
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PaymentDetailsCollectionViewCell.identifier,
                for: indexPath) as! PaymentDetailsCollectionViewCell
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PinCollectionViewCell.identifier,
                for: indexPath) as! PinCollectionViewCell
            cell.delegate = self
            return cell
        default: fatalError("Cell not configured")
        }
    }
}

extension ConfirmationViewController: PinCellDelegate {
    func getPin(_ pin: String?) {
        self.pin = pin
    }
}
