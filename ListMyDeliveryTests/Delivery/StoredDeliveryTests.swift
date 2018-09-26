//
//  StoredDeliveryTests.swift
//  ListMyDeliveryTests
//
//  Created by Jitendra on 26/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import XCTest
@testable import ListMyDelivery

extension DeliveryTests {
    
    func testConvertToStorage() {

        let location = Location(latitude: 33.4521, longitude: 16.4521, address: "Sample Address")
        
        let delivery = Delivery(id: 15,
                                description: "Sample Descripition",
                                imageUrl: URL(string: "https://example.com/image.jpeg")!,
                                location: location)
        
        let storedDelivery = delivery.convertToStorage()
        XCTAssertEqual(delivery.id, storedDelivery.id)
        XCTAssertEqual(delivery.description, storedDelivery.desc)
        XCTAssertEqual(delivery.imageUrl.lastPathComponent, storedDelivery.imageName)
        XCTAssertEqual(delivery.location.latitude, storedDelivery.location.latitude)
        XCTAssertEqual(delivery.location.longitude, storedDelivery.location.longitude)
        XCTAssertEqual(delivery.location.address, storedDelivery.location.address)
    }
    
    func testConvertFromStorage() {
    
        let storedLocation = StoredLocation()
        storedLocation.latitude = 33.4521
        storedLocation.longitude = 16.4521
        storedLocation.address = "Sample Address"

        let storedDelivery = StoredDelivery()
        storedDelivery.id = 15
        storedDelivery.desc = "Sample Descripition"
        storedDelivery.imageName = "image.jpeg"
        storedDelivery.location = storedLocation
        
        let delivery = Delivery.convertFromStorage(storedDelivery)
        XCTAssertEqual(delivery.id, storedDelivery.id)
        XCTAssertEqual(delivery.description, storedDelivery.desc)
        XCTAssertEqual(delivery.imageUrl.lastPathComponent, storedDelivery.imageName)
        XCTAssertEqual(delivery.location.latitude, storedDelivery.location.latitude)
        XCTAssertEqual(delivery.location.longitude, storedDelivery.location.longitude)
        XCTAssertEqual(delivery.location.address, storedDelivery.location.address)
        
        if let librarayPath = FileManager.default.libraryPath() {
            let url = librarayPath.appendingPathComponent(storedDelivery.imageName)
            XCTAssertEqual(delivery.imageUrl, url)
        } else {
            XCTFail("Failed to get library path.")
        }
    }
}
