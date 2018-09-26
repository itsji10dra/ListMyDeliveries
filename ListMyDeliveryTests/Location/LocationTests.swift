//
//  LocationTests.swift
//  ListMyLocationTests
//
//  Created by Jitendra on 26/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import XCTest
@testable import ListMyDelivery

class LocationTests: XCTestCase {

    // MARK: - Decoding
    
    func testJSONDecodingCase1() {
        
        let testBundle = Bundle(for: type(of: self))
        guard let fileURL = testBundle.url(forResource: "LocationCase1", withExtension: "json") else {
            return XCTFail("Unable to load JSON from bundle")
        }
        
        guard let data = try? Data(contentsOf: fileURL) else { return XCTFail("Data conversion failed.") }

        do {
            let location = try JSONDecoder().decode(Location.self, from: data)
            XCTAssertEqual(location.latitude, 22.319181)
            XCTAssertEqual(location.longitude, 114.170008)
            XCTAssertEqual(location.address, "Mong Kok")
        } catch {
            XCTFail("Case 1. JSON Decoding for class \(Location.self) failed.")
        }
    }
    
    func testJSONDecodingCase2() {
        
        let testBundle = Bundle(for: type(of: self))
        guard let fileURL = testBundle.url(forResource: "LocationCase2", withExtension: "json") else {
            return XCTFail("Unable to load JSON from bundle")
        }
        
        guard let data = try? Data(contentsOf: fileURL) else { return XCTFail("Data conversion failed.") }

        do {
            let _ = try JSONDecoder().decode(Location.self, from: data)
            XCTFail("Case 2. JSON Decoding succeed for class \(Location.self) even when `address` is missing.")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
