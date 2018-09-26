//
//  StoredLocationTests.swift
//  ListMyDeliveryTests
//
//  Created by Jitendra on 26/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import XCTest
@testable import ListMyDelivery

class StoredLocationTests: XCTestCase {
    
    func testConvertToStorage() {
        
        let location = Location(latitude: 33.4521,
                                longitude: 16.4521,
                                address: "Sample Address")
        
        let storedLocation = location.convertToStorage()
        XCTAssertEqual(location.latitude, storedLocation.latitude)
        XCTAssertEqual(location.longitude, storedLocation.longitude)
        XCTAssertEqual(location.address, storedLocation.address)
    }
    
    func testConvertFromStorage() {
        
        let storedLocation = StoredLocation()
        storedLocation.latitude = 33.4521
        storedLocation.longitude = 16.4521
        storedLocation.address = "Sample Address"
        
        let location = Location.convertFromStorage(storedLocation)
        XCTAssertEqual(location.latitude, storedLocation.latitude)
        XCTAssertEqual(location.longitude, storedLocation.longitude)
        XCTAssertEqual(location.address, storedLocation.address)
    }
}
