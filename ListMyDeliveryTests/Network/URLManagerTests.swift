//
//  URLManagerTests.swift
//  ListMyDeliveryTests
//
//  Created by Jitendra on 26/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import XCTest
@testable import ListMyDelivery

class URLManagerTests: XCTestCase {

    func testGetURLForEndpoint() {
        
        guard let url = URLManager.getURLForEndpoint(.deliveries) else {
            return XCTFail("Endpoint deliveries returning nil URL")
        }
        XCTAssertNotNil(url)
        
        guard let configuredURL = URL(string: Configuration.url) else {
            return XCTFail("Configured string URL not converting to Foundation URL.")
        }
        XCTAssertNotNil(configuredURL)

        XCTAssertEqual(url.host, configuredURL.host)
        XCTAssertEqual(url.scheme, configuredURL.scheme)
        XCTAssertEqual(url.user, configuredURL.user)
        XCTAssertEqual(url.password, configuredURL.password)
        XCTAssertEqual(url.port, configuredURL.port)
        
        guard let query = url.query else { return XCTFail("Query items not found.") }
        XCTAssertTrue(query.contains("offset"))
        XCTAssertTrue(query.contains("limit"))

        let pathComponents = url.pathComponents
        XCTAssertNotNil(pathComponents)
        XCTAssertEqual(pathComponents.count, 2)
        XCTAssertEqual(pathComponents.joined(), EndPoint.deliveries.rawValue)
        
        guard let urlComponent = URLComponents(string: url.absoluteString) else {
            return XCTFail("Failed to generate `URLComponent` from `url`.")
        }
        XCTAssertEqual(urlComponent.queryItems?.count, 2)
        
        let offsetValue = urlComponent.queryItems?.first(where: {$0.name == "offset"})?.value
        XCTAssertNotNil(offsetValue)
        XCTAssertEqual(offsetValue, "0")

        let limitValue = urlComponent.queryItems?.first(where: {$0.name == "limit"})?.value
        XCTAssertNotNil(limitValue)
        XCTAssertEqual(limitValue, "\(Configuration.pageLimit)")
    }
}
