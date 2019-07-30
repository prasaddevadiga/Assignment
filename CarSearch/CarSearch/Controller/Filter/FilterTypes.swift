//
//  FilterTypes.swift
//  CarSearch
//
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit

enum Country: String {
    case NL = "NL"
    case DE = "DE"
    case DK = "DK"
    case SE = "SE"
    
    static func country(at index: Int) -> Country? {
        let elements = [Country.NL, Country.DE, Country.DK, Country.SE]
        if index >= 0 && index < elements.count {
            return elements[index]
        } else {
            return nil
        }
    }
}

enum SortType: String {
    case recommended = "recommended"
    case price       = "price"
    case distance    = "distance"
    
    static func sortType(at index: Int) -> SortType? {
        let elements = [SortType.recommended, SortType.price, SortType.distance]
        if index >= 0 && index < elements.count {
            return elements[index]
        } else {
            return nil
        }
    }
}

enum SortOrder: String {
    case asc  = "asc"
    case desc = "desc"
    
    static func sortOrder(at index: Int) -> SortOrder? {
        let elements = [SortOrder.asc, SortOrder.desc]
        
        if index >= 0 && index < elements.count {
            return elements[index]
        } else {
            return nil
        }
    }
}
