//
//  StoredDelivery.swift
//  ListMyDelivery
//
//  Created by Jitendra on 17/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import RealmSwift

class StoredDelivery: Object {
    
    @objc dynamic var id: Int16 = -1
    
    @objc dynamic var desc: String = ""
    
    @objc dynamic var imageName: String = ""
    
    @objc dynamic var location: StoredLocation!
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
