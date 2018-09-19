//
//  StoredLocation.swift
//  ListMyDelivery
//
//  Created by Jitendra on 17/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import RealmSwift

class StoredLocation: Object {
    
    @objc dynamic var latitude: Double = 0.0
    
    @objc dynamic var longitude: Double = 0.0
    
    @objc dynamic var address: String = ""
}
