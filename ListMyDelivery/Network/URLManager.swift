//
//  URLManager.swift
//  ListMyDelivery
//
//  Created by Jitendra on 17/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Foundation

struct URLManager {
    
    // MARK: - Public
    
    static func getURLForEndpoint(_ endPoint: EndPoint, offset: UInt = 0) -> URL? {
        
        let endPoint = endPoint.rawValue
        var urlComponents = URLComponents(string: Configuration.url + endPoint)
        
        let parameters = getLimitingParameters(with: offset)
        let queryParameters = parameters.map { URLQueryItem(name: $0, value: $1) }
        
        urlComponents?.queryItems = queryParameters
        
        return urlComponents?.url
    }
    
    // MARK: - Private
    
    static private func getLimitingParameters(with offset: UInt) -> [String:String] {
        return ["offset"    : "\(offset)",
                "limit"     : "\(Configuration.pageLimit)"]
    }
}
