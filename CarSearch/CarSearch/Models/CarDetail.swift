//
//  CarDetail.swift
//  CarSearch
//
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit

class CarDetail: Codable {
    var ci: String?
    var distance: Double?
    var user: User?
    var priceInformation: PriceInformation?
    var car: Car?
    var flags: Flags?
}
