//
//  URLBuilder.swift
//  CarSearch
//
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit

enum Component: String {
    case scheme = "https"
    case host = "api.snappcar.nl"
    case path = "/v2/search/query"
}

class URLBuilder: NSObject {
    var queryItems: [String: String] = [:]
    
    func addQuery(with query: String?, value: String?) -> URLBuilder {
        guard let inQuery = query, let inValue = value else { return self }
        queryItems.updateValue(inValue, forKey: inQuery)
        return self
    }
    
    func build() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Component.scheme.rawValue
        urlComponents.host = Component.host.rawValue
        urlComponents.path = Component.path.rawValue
        let queryItem = queryItems.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }
        urlComponents.queryItems = queryItem
        return urlComponents.url
    }
}
