//
//  RutaSeguraTests.swift
//  RutaSeguraTests
//
//  Created by Irving Delgado Silva on 25/11/22.
//

import XCTest
import NetworkLayer
@testable import RutaSegura

final class RutaSeguraTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Testing wether the app is correctly sending requests to getRoute endpoint using networkClient.
    func testNetworkClientPerformValidGetRouteRequest() {
        // Given
        if let url = URL(string: AppConstants.API.baseURL) {
            let sut = NetworkClient(baseURL: url)
            
            let routePath = String(format: AppConstants.API.getRouteEndpoint, 5, 10)
            
            let request = NetworkRequest(method: RequestMethod.GET, path: routePath, parameters: nil, headers: nil)
            
            let expectation = self.expectation(description: "Waiting for perform call to complete.")
            
            var result: Result<RutaSeguraEntity, NetworkError>?
            
            do {
                // When
                try sut.performRequestAndDecode(networkRequest: request) { (response: Result<RutaSeguraEntity, NetworkError>) in
                    result = response
                    expectation.fulfill()
                }

                // Wait for expectation to finish
                waitForExpectations(timeout: 2) { error in
                    XCTAssertNil(error)
                    switch result {
                    case .success(let routeModel):
                        XCTAssertEqual(routeModel.costoRuta, 1392)
                    case .failure(let networkErr):
                        XCTFail(networkErr.localizedDescription)
                    case .none:
                        XCTFail("None")
                    }
                }
            } catch {
                XCTFail(error.localizedDescription)
            }
                        
        } else {
            XCTFail("Can't create url from string")
        }
    }

}
