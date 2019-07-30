//
//  CarList.swift
//  CarSearch
//
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit

class CarList: Codable {
    var results: [CarDetail]?
    var sums: Sums?
    var searchID: String?
    
    enum CodingKeys: String, CodingKey {
        case results, sums
        case searchID = "searchId"
    }
}
