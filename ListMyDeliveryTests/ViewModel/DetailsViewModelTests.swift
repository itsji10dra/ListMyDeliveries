//
//  DetailsViewModelTests.swift
//  ListMyDeliveryTests
//
//  Created by Jitendra on 26/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import XCTest
@testable import ListMyDelivery

class DetailsViewModelTests: XCTestCase {

    func testInit() {
        
        let location = Location(latitude: 33.4521, longitude: 16.4521, address: "Sample Address")
        
        let delivery = Delivery(id: 15,
                                description: "Sample Descripition",
                                imageUrl: URL(string: "https://example.com/image.jpeg")!,
                                location: location)
        
        let detailsViewModel = DetailsViewModel(with: delivery)
        XCTAssertEqual(detailsViewModel.description, delivery.description)
        XCTAssertEqual(detailsViewModel.imageUrl, delivery.imageUrl)
        XCTAssertEqual(detailsViewModel.address, delivery.location.address)
        XCTAssertEqual(detailsViewModel.coordinates.latitude, delivery.location.latitude)
        XCTAssertEqual(detailsViewModel.coordinates.longitude, delivery.location.longitude)
    }
}
