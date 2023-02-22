//
//  HomepageViewController.swift
//  Topuppin
//
//  Created by Giri Bahari on 18/02/23.
//

import UIKit

class HomepageViewController: UIViewController {

    lazy var viewPager: ViewPager = {
        let viewPager = ViewPager(tabSizeConfiguration: .fillEqually(height: 60, spacing: 0))
        let storyboard = UIStoryboard(name: "Homepage", bundle: nil)

        let pulsaVC = storyboard.instantiateViewController(withIdentifier: "PulsaViewController") as! PulsaViewController
        pulsaVC.delegate = self
        let dataPackageVC = storyboard.instantiateViewController(withIdentifier: "DataPackageViewController") as! DataPackageViewController
        dataPackageVC.delegate = self

        viewPager.tabbedView.tabs = [
            TabItemView(title: "Pulsa"),
            TabItemView(title: "Data Package")
        ]

        viewPager.pagedView.pages = [
            pulsaVC,
            dataPackageVC
        ]

        viewPager.translatesAutoresizingMaskIntoConstraints = false
        return viewPager
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(viewPager)

        NSLayoutConstraint.activate([
            viewPager.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            viewPager.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            viewPager.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            viewPager.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        ])
    }

}

extension HomepageViewController: PulsaDelegate, DataPackageaDelegate {
    func didSeletPromotion(promo: Promo) {
        let storyboard = UIStoryboard(name: "Promo", bundle: nil)
        let promoVC = storyboard.instantiateViewController(withIdentifier: "PromoViewController") as! PromoViewController
        promoVC.promo = promo
        self.navigationController?.pushViewController(promoVC, animated: true)
    }

    func didSelectNominal(loanData: ConfirmationModel) {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let confirmationVC = storyboard.instantiateViewController(withIdentifier: "ConfirmationViewController") as! ConfirmationViewController
        confirmationVC.loanData = loanData
        self.navigationController?.pushViewController(confirmationVC, animated: true)
    }
}
