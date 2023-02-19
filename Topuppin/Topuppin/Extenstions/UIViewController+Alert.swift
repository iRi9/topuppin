//
//  UIViewController+Alert.swift
//  Topuppin
//
//  Created by Giri Bahari on 18/02/23.
//

import UIKit

extension UIViewController {
    func showWarningAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(action)

        present(alertController, animated: true)
    }
}
