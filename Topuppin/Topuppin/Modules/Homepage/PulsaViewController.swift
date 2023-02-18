//
//  PulsaViewController.swift
//  Topuppin
//
//  Created by Giri Bahari on 18/02/23.
//

import UIKit
import XLPagerTabStrip

class PulsaViewController: UIViewController, IndicatorInfoProvider {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Pulsa")
    }

    
}
