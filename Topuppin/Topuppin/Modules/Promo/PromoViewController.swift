//
//  PromoViewController.swift
//  Topuppin
//
//  Created by Giri Bahari on 20/02/23.
//

import UIKit

class PromoViewController: UIViewController {

    var promo: Promo!

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupNavigationBarIcon()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
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

        collectionView.register(HeaderPromoCollectionViewCell.nib,
                                forCellWithReuseIdentifier: HeaderPromoCollectionViewCell.identifier)
        collectionView.register(PromoDateCollectionViewCell.nib,
                                forCellWithReuseIdentifier: PromoDateCollectionViewCell.identifier)
        collectionView.register(VoucherCollectionViewCell.nib,
                                forCellWithReuseIdentifier: VoucherCollectionViewCell.identifier)
        collectionView.register(TermConditionCollectionViewCell.nib,
                                forCellWithReuseIdentifier: TermConditionCollectionViewCell.identifier)

        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0: return PromoLayout.shared.bannerSection()
            case 1: return PromoLayout.shared.dateSection()
            case 2: return PromoLayout.shared.voucherSection()
            case 3: return PromoLayout.shared.termSection()
            default: fatalError("Layout not configured")
            }

        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }

}

// MARK: UICollectionViewDelegate -
extension PromoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
                withReuseIdentifier: HeaderPromoCollectionViewCell.identifier,
                for: indexPath) as! HeaderPromoCollectionViewCell

            cell.configure(with: promo)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PromoDateCollectionViewCell.identifier,
                for: indexPath) as! PromoDateCollectionViewCell
            cell.configure(with: promo)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: VoucherCollectionViewCell.identifier,
                for: indexPath) as! VoucherCollectionViewCell
            cell.delegate = self
            cell.configure(with: promo)
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TermConditionCollectionViewCell.identifier,
                for: indexPath) as! TermConditionCollectionViewCell

            cell.configure(with: promo.termConditions)
            return cell
        default: fatalError("Cell not configured")
        }
    }
}

// MARK: VoucherCellDelegate -
extension PromoViewController: VoucherCellDelegate {
    func copy(text: String?) {
        if let text = text {
            UIPasteboard.general.string = text
            showWarningAlert(title: "Info", message: "Voucher copied!")
        }
    }
}
