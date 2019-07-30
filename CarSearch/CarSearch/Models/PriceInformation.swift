//
//  PriceInformation.swift
//  CarSearch
//
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit

class PriceInformation: Codable {
    var price: Double?
    var pricePerKilometer: Double?
    var freeKilometersPerDay: Double?
    var rentalDays: Int?
    var isoCurrencyCode: String?
}
