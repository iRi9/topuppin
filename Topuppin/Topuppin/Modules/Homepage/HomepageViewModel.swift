//
//  HomepageViewModel.swift
//  Topuppin
//
//  Created by Giri Bahari on 18/02/23.
//

import Foundation

// MARK: - HomepageViewModel
struct HomepageViewModel: Decodable {
    let phone: PhoneNumberModel
    let nominals: [NominalModel]
    let promos: [Promo]
}

struct Promo: Decodable {
    let image: String
    let title: String
    let promoPeriod: String
    let promoCode: String
    let termConditions: [String]
}
