//
//  Location.swift
//  ListMyDelivery
//
//  Created by Jitendra on 15/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

struct Location: Decodable {
    
    let latitude: Double
    
    let longitude: Double
    
    let address: String
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
        case address
    }
}

extension Location: Storable {
    
    typealias StorageClass = StoredLocation
    
    func convertToStorage() -> StoredLocation {
        
        let storedLocation = StoredLocation()
        storedLocation.latitude = self.latitude
        storedLocation.longitude = self.longitude
        storedLocation.address = self.address
        return storedLocation
    }
    
    static func convertFromStorage(_ storage: StoredLocation) -> Location {

        let location = Location(latitude: storage.latitude,
                                longitude: storage.longitude,
                                address: storage.address)
        return location
    }
}
