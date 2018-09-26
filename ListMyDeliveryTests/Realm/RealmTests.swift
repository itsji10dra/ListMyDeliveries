//
//  RealmTests.swift
//  ListMyDeliveryTests
//
//  Created by Jitendra on 26/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import XCTest
import RealmSwift
@testable import ListMyDelivery

class RealmTests: XCTestCase {

    override func setUp() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "TestingRealm"
    }
    
    func testSave() {
        let storedLocation = StoredLocation()
        storedLocation.latitude = 33.4521
        storedLocation.longitude = 16.4521
        storedLocation.address = "Sample Address"
        
        let storedDelivery = StoredDelivery()
        storedDelivery.id = 15
        storedDelivery.desc = "Sample Descripition"
        storedDelivery.imageName = "image.jpeg"
        storedDelivery.location = storedLocation
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(storedDelivery)
        }

        let retrievedDelivery = realm.objects(StoredDelivery.self).first
        XCTAssertNotNil(retrievedDelivery)
        XCTAssertEqual(retrievedDelivery?.id, storedDelivery.id)
        XCTAssertEqual(retrievedDelivery?.desc, storedDelivery.desc)
        XCTAssertEqual(retrievedDelivery?.imageName, storedDelivery.imageName)
        XCTAssertEqual(retrievedDelivery?.location.latitude, storedLocation.latitude)
        XCTAssertEqual(retrievedDelivery?.location.longitude, storedLocation.longitude)
        XCTAssertEqual(retrievedDelivery?.location.address, storedLocation.address)
    }
    
    func testUpdate() {

        let storedLocation = StoredLocation()
        storedLocation.latitude = 33.4521
        storedLocation.longitude = 16.4521
        storedLocation.address = "Sample Address"

        let storedDelivery = StoredDelivery()
        storedDelivery.id = 20
        storedDelivery.desc = "Sample Descripition"
        storedDelivery.imageName = "image.jpeg"
        storedDelivery.location = storedLocation

        let realm = try! Realm()
        try! realm.write {
            realm.add(storedDelivery)
        }

        let updatedStoredLocation = StoredLocation()
        updatedStoredLocation.latitude = 39.4521
        updatedStoredLocation.longitude = 26.4521
        updatedStoredLocation.address = "Updated Sample Address"

        try! realm.write {
            storedDelivery.location = updatedStoredLocation
        }

        let retrievedDelivery = realm.objects(StoredDelivery.self).first
        XCTAssertNotNil(retrievedDelivery)
        XCTAssertEqual(retrievedDelivery?.id, storedDelivery.id)
        XCTAssertEqual(retrievedDelivery?.desc, storedDelivery.desc)
        XCTAssertEqual(retrievedDelivery?.imageName, storedDelivery.imageName)
        XCTAssertEqual(retrievedDelivery?.location.latitude, updatedStoredLocation.latitude)
        XCTAssertEqual(retrievedDelivery?.location.longitude, updatedStoredLocation.longitude)
        XCTAssertEqual(retrievedDelivery?.location.address, updatedStoredLocation.address)
    }
    
    func testDelete() {
        
        let storedLocation1 = StoredLocation()
        storedLocation1.latitude = 33.4521
        storedLocation1.longitude = 16.4521
        storedLocation1.address = "Sample Address 1"
        
        let storedLocation2 = StoredLocation()
        storedLocation2.latitude = 35.6878
        storedLocation2.longitude = 71.982
        storedLocation2.address = "Sample Address 2"
        
        let storedLocation3 = StoredLocation()
        storedLocation3.latitude = 76.2121
        storedLocation3.longitude = 12.2123
        storedLocation3.address = "Sample Address 3"

        let realm = try! Realm()
        
        let locations = realm.objects(StoredLocation.self)
        XCTAssertEqual(locations.count, 0)

        try! realm.write {
            realm.add([storedLocation1, storedLocation2, storedLocation3])
        }
        XCTAssertEqual(locations.count, 3)
        
        try! realm.write {
            realm.delete(storedLocation2)
        }
        XCTAssertEqual(locations.count, 2)

        try! realm.write {
            realm.deleteAll()
        }
        XCTAssertEqual(locations.count, 0)
    }
}
