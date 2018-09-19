//
//  Protocols.swift
//  ListMyDelivery
//
//  Created by Jitendra on 17/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import RealmSwift

protocol Storable {
    
    associatedtype StorageClass: Object
    
    func convertToStorage() -> StorageClass
    
    static func convertFromStorage(_ storage: StorageClass) -> Self
}
