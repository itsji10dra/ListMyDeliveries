//
//  RealmManager.swift
//  ListMyDelivery
//
//  Created by Jitendra on 17/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import RealmSwift

class RealmManager {
    
    public static let shared = RealmManager()
    
    private let queue = DispatchQueue(label: "RealmQueue", qos: .default, target: .main)
    
    // MARK: - Initializer
    
    private init() { } 

    // MARK: - Public
    
    public func printRealmPath() {
        print(Realm.Configuration.defaultConfiguration.fileURL?.absoluteString ?? "N/A")
    }

    public func get<T: Object>(with offset: Int) -> [T] {

        let realm = try! Realm()

        let result = realm.objects(T.self).sorted(byKeyPath: "id")

        guard result.isEmpty == false else { return [] }

        let idealLimit = offset + Configuration.pageLimit
        let limit = idealLimit < result.count ? idealLimit : result.count

        guard offset < limit else { return [] }
        
        var data: [T] = []

        for index in offset..<limit {
            let delivery = result[index]
            data.append(delivery)
        }

        return data
    }
    
    public func save<T: Object>(data: [T]) {
        
        queue.async {
            let realm = try! Realm()
            try! realm.write {
                realm.add(data, update: true)
            }
        }
    }
}
