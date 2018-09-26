//
//  DeliveryTests.swift
//  ListMyDeliveryTests
//
//  Created by Jitendra on 26/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import XCTest
@testable import ListMyDelivery

class DeliveryTests: XCTestCase {

    override func setUp() {

    }

    override func tearDown() {

    }
    
    // MARK: - Decoding
    
    func testJSONDecodingCase1() {
        
        let testBundle = Bundle(for: type(of: self))
        guard let fileURL = testBundle.url(forResource: "DeliveryCase1", withExtension: "json") else {
            XCTFail("Unable to load sample JSON")
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
            let delivery = try JSONDecoder().decode(Delivery.self, from: data)
            XCTAssertEqual(delivery.id, 3)
            XCTAssertEqual(delivery.description, "Deliver documents to Simon")
            XCTAssertEqual(delivery.imageUrl.absoluteString, "https://example.com/image.jpeg")
            XCTAssertNotNil(delivery.location)
        } catch {
            XCTFail("Case 1. JSON Decoding for class \(Delivery.self) failed.")
        }
    }
    
    func testJSONDecodingCase2() {
        
        let testBundle = Bundle(for: type(of: self))
        guard let fileURL = testBundle.url(forResource: "DeliveryCase2", withExtension: "json") else {
            XCTFail("Unable to load sample JSON")
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
            let _ = try JSONDecoder().decode(Delivery.self, from: data)
            XCTFail("Case 2. JSON Decoding succeed for class \(Delivery.self) even when `location` is missing.")
        } catch {
            XCTAssertNotNil(error)
        }
    }

}
