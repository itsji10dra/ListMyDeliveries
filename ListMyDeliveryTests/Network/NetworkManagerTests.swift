//
//  NetworkManagerTests.swift
//  ListMyDeliveryTests
//
//  Created by Jitendra on 26/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import XCTest
@testable import ListMyDelivery

class NetworkManagerTests: XCTestCase {

    var session: URLSessionMock!
    var manager: NetworkManager!

    override func setUp() {
        session = URLSessionMock()
        manager = NetworkManager(session: session)
    }
    
    func testSuccess() {
        
        let data = getSuccessData()
        session.data = data

        let url = URL(fileURLWithPath: "http://mocktest.url")

        var result: Result<[Delivery]>? = nil
        let task = manager.dataTaskFromURL(url, completion: { result = $0 })
        task.resume()
        XCTAssertNotNil(result)

        switch result {
        case .success(let response)?:
            XCTAssertNotNil(response)
            XCTAssertEqual(response.count, 20)
            
        case .failure(let error)?:
            XCTAssertNil(error)
        
        case .none:
            XCTFail("Unknown Case Occurred")
        }
    }
    
    private func getSuccessData() -> Data {
        
        let testBundle = Bundle(for: type(of: self))
        
        guard let fileURL = testBundle.url(forResource: "Success", withExtension: "json") else {
            fatalError("Unable to load JSON from bundle")
        }
        
        guard let data = try? Data(contentsOf: fileURL) else { fatalError("Data conversion failed.") }
        
        return data
    }
}
