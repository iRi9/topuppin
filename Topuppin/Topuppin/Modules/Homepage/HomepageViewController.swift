//
//  HomepageViewController.swift
//  Topuppin
//
//  Created by Giri Bahari on 18/02/23.
//

import UIKit
import XLPagerTabStrip

class HomepageViewController: ButtonBarPagerTabStripViewController {

    let purpleInspireColor = UIColor.red

    override func viewDidLoad() {
        setupPagerTab()
        super.viewDidLoad()
    }

    func setupPagerTab() {
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = UIColor(named: "SecondaryColor")!
        settings.style.buttonBarItemFont = .systemFont(ofSize: 14)
        settings.style.selectedBarHeight = 3
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarRightContentInset = 0
        settings.style.buttonBarLeftContentInset = 0
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .systemGray
            oldCell?.label.font = .systemFont(ofSize: 14)
            newCell?.label.textColor = UIColor(named: "SecondaryColor")!
            newCell?.label.font = .boldSystemFont(ofSize: 14)
        }
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let pulsaVC = UIStoryboard(name: "Homepage", bundle: nil).instantiateViewController(withIdentifier: "PulsaViewController")
        let dataVC = UIStoryboard(name: "Homepage", bundle: nil).instantiateViewController(withIdentifier: "DataPackageViewController")
        return [pulsaVC, dataVC]
    }

}
