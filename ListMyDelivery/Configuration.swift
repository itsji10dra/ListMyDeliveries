//
//  Configuration.swift
//  ListMyDelivery
//
//  Created by Jitendra on 15/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

struct Configuration {
    
    // MARK: - Static Configuration

    static let url          = "https://mock-api-mobile.dev.lalamove.com"
    
    static let pageLimit    = 15
    
    static func checkConfiguration() {
        
        if url.isEmpty || pageLimit < 0 {
            fatalError("""
                Invalid configuration found
            """)
        }
    }
    
    // MARK: - Initializer

    private init() {}       //To avoid instance creation
}
