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

    // MARK: - Decoding
    
    func testJSONDecodingCase1() {
        
        let testBundle = Bundle(for: type(of: self))
        guard let fileURL = testBundle.url(forResource: "DeliveryCase1", withExtension: "json") else {
            return XCTFail("Unable to load JSON from bundle")
        }
        
        guard let data = try? Data(contentsOf: fileURL) else { return XCTFail("Data conversion failed.") }

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
            return XCTFail("Unable to load JSON from bundle")
        }
        
        guard let data = try? Data(contentsOf: fileURL) else { return XCTFail("Data conversion failed.") }

        do {
            let _ = try JSONDecoder().decode(Delivery.self, from: data)
            XCTFail("Case 2. JSON Decoding succeed for class \(Delivery.self) even when `location` is missing.")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
