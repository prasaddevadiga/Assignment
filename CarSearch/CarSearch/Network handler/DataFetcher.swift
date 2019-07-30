//
//  DataFetcher.swift
//  CarSearch
//
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit

class DataFetcher: NSObject {
    
    var urlBuilder = URLBuilder()
    func loadCarListData(with filterParameter: FilterParameter, completionHandler: @escaping (_ cartList: CarList?, _ error: Error?) -> Void) {
        
        _ = urlBuilder.addQuery(with: "limit", value: String(filterParameter.limit))
            .addQuery(with: "country", value: filterParameter.country?.rawValue)
            .addQuery(with: "order", value: filterParameter.sortOrder?.rawValue)
            .addQuery(with: "sort", value: filterParameter.sorting?.rawValue)
            .addQuery(with: "offset", value: String(filterParameter.offset))
        
        guard let url = urlBuilder.build() else { return }
        
        let defaultSession = URLSession(configuration: .default)
        defaultSession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let _data = data else {
                    completionHandler(nil, error)
                    return
                }
                do {
                    let jsonDecoder = JSONDecoder()
                    let carListDetails = try jsonDecoder.decode(CarList.self, from: _data)
                    completionHandler(carListDetails, nil)
                } catch {
                    completionHandler(nil, error)
                }
            }
            }.resume()
    }
}
