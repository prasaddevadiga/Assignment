//
//  Car.swift
//  CarSearch
//
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit

class Car: NSObject, Codable {
    var reviewAvg: Int?
    var fuelType, createdAt, ownerID: String?
    var year, reviewCount: Int?
    var make: String?
    var gear, bodyType: String?
    var model: String?
    var seats: Int?
    var allowed, accessories: [String]?
    var images: [String]?
    
    enum CodingKeys: String, CodingKey {
        case reviewAvg, fuelType, createdAt
        case ownerID = "ownerId"
        case year, reviewCount, make, gear, bodyType, model, seats, allowed, accessories, images
    }
    
    // By default codable will take care of the parsing
    // As type of 'model' was dynamic so I had to do the follwoing code implementation to handle that
    // Otherwise this method implementation is not required
    
    required init(from decoder: Decoder) throws {
        do {
            if let container = try? decoder.container(keyedBy: CodingKeys.self) {
                if let stringProperty = try? container.decode(Int.self, forKey: .model) {
                    model = String(stringProperty)
                } else if let intProperty = try? container.decode(String.self, forKey: .model) {
                    model = intProperty
                }
                
                reviewAvg = try? container.decode(Int.self, forKey: .reviewAvg)
                fuelType = try? container.decode(String.self, forKey: .fuelType)
                createdAt = try? container.decode(String.self, forKey: .createdAt)
                ownerID = try? container.decode(String.self, forKey: .ownerID)
                year = try? container.decode(Int.self, forKey: .year)
                reviewCount = try? container.decode(Int.self, forKey: .reviewCount)
                make = try? container.decode(String.self, forKey: .make)
                gear = try? container.decode(String.self, forKey: .gear)
                bodyType = try? container.decode(String.self, forKey: .bodyType)
                seats = try? container.decode(Int.self, forKey: .seats)
                allowed = try? container.decode([String].self, forKey: .allowed)
                accessories = try? container.decode([String].self, forKey: .accessories)
                images = try? container.decode([String].self, forKey: .images)
            }
        }
    }
}
