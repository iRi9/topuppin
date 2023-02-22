//
//  HomepageViewModel.swift
//  Topuppin
//
//  Created by Giri Bahari on 18/02/23.
//

import Foundation

// MARK: - PulsaModel
struct PulsaModel: Decodable {
    let phone: PhoneNumberModel
    let nominals: [NominalModel]
    let promos: [Promo]
}

struct DataPackageModel: Decodable {
    let phone: PhoneNumberModel
    let packages: [NominalModel]
    let promos: [Promo]
}

struct Promo: Decodable {
    let image: String
    let title: String
    let promoPeriod: String
    let promoCode: String
    let termConditions: [String]
}
