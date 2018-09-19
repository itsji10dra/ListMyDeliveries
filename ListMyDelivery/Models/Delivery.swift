//
//  Delivery.swift
//  ListMyDelivery
//
//  Created by Jitendra on 15/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Foundation

struct Delivery: Decodable {
    
    let id: Int16
    
    let description: String
    
    let imageUrl: URL
    
    let location: Location
}

extension Delivery: Storable {
    
    typealias StorageClass = StoredDelivery
    
    func convertToStorage() -> StoredDelivery {
        
        let storedDelivery = StoredDelivery()
        storedDelivery.id = self.id
        storedDelivery.desc = self.description
        storedDelivery.imageName = self.imageUrl.lastPathComponent
        storedDelivery.location = self.location.convertToStorage()
        return storedDelivery
    }
    
    static func convertFromStorage(_ storage: StoredDelivery) -> Delivery {
        
        let imageURL = FileManager.default.libraryPath()?.appendingPathComponent(storage.imageName)
        
        let delivery = Delivery(id: storage.id,
                                description: storage.desc,
                                imageUrl: imageURL!,
                                location: Location.convertFromStorage(storage.location))
        
        return delivery
    }
}
