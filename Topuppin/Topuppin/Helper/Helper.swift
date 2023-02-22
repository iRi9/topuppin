//
//  Helper.swift
//  Topuppin
//
//  Created by Giri Bahari on 22/02/23.
//

import Foundation

class Helper {
    static let shared = Helper()

    func formatToRp(price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id")
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencySymbol = ""
        formatter.minimumFractionDigits = 0
        guard let formattedPrice = formatter.string(from: price as NSNumber) else {
            return "Rp 0"
        }

        let result = formattedPrice.replacingOccurrences(of: ",00", with: "")

        return "Rp \(result)"
    }

}
