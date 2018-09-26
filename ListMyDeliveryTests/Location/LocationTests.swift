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
            XCTFail("Unable to load JSON from bundle")
            return
        }
        
        var stringJSON: String? = nil
        do {
            stringJSON = try String(contentsOf: fileURL)
        } catch {
            XCTFail("JSON loading from file failed.")
        }
        XCTAssertNotNil(stringJSON)
        
        guard let data = stringJSON?.data(using: .utf8) else { return }
        
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
            XCTFail("Unable to load JSON from bundle")
            return
        }
        
        var stringJSON: String? = nil
        do {
            stringJSON = try String(contentsOf: fileURL)
        } catch {
            XCTFail("JSON loading from file failed.")
        }
        XCTAssertNotNil(stringJSON)
        
        guard let data = stringJSON?.data(using: .utf8) else { return }
        
        do {
            let _ = try JSONDecoder().decode(Location.self, from: data)
            XCTFail("Case 2. JSON Decoding succeed for class \(Location.self) even when `address` is missing.")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
