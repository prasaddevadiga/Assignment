//
//  QueryParameter.swift
//  CarSearch
//
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit

struct FilterParameter {
    var country: Country?
    var sorting: SortType?
    var sortOrder: SortOrder? = .asc
    var limit: Int = 10
    var offset: Int = 0
}
