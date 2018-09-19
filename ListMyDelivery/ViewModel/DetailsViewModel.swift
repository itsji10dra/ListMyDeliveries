//
//  DetailsViewModel.swift
//  ListMyDelivery
//
//  Created by Jitendra on 17/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Foundation
import MapKit

struct DetailsViewModel {
    
    let coordinates: CLLocationCoordinate2D
    
    let description: String
    
    let imageUrl: URL
    
    let address: String
    
    init(with info: Delivery) {
        
        self.description = info.description
        self.imageUrl = info.imageUrl
        self.address = info.location.address

        let latitude = info.location.latitude
        let longitude = info.location.longitude
        self.coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
