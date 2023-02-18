//
//  DataPackageViewController.swift
//  Topuppin
//
//  Created by Giri Bahari on 18/02/23.
//

import UIKit
import XLPagerTabStrip

class DataPackageViewController: UIViewController, IndicatorInfoProvider {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Data Package")
    }

}
