//
//  PaginationModel.swift
//  CarSearch
//
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit

class PaginationModel: NSObject {
    var currentPage = 0
    var totalNumber = 0
    var pageSize = 0
    var dataFetching: Bool = false
    
    func shouldFetchData() -> Bool {
        guard totalNumber != 0 else {
            return false
        }
        
        guard dataFetching == false else { return false }
        if ((currentPage + 1) * pageSize < totalNumber) {           // increasing as current page index start from 0
            return true
        }
        return false
    }
    
    func resetValue() {
        currentPage = 0
        totalNumber = 0
        pageSize = 0
        dataFetching = false
    }
}
