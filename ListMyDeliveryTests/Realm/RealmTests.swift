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
    
    func testGet() {
        
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
}
