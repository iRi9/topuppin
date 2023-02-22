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

        let pulsaVC = storyboard.instantiateViewController(withIdentifier: "PulsaViewController")
        let dataPackageVC = storyboard.instantiateViewController(withIdentifier: "DataPackageViewController")

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
