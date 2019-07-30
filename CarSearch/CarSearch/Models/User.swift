//
//  User.swift
//  CarSearch
//
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit

class User: Codable {
    var firstName: String?
    var imageURL: String?
    var street, city: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case imageURL = "imageUrl"
        case street, city
    }
}
