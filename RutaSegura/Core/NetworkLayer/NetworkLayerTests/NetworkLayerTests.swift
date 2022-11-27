//
//  NetworkLayerTests.swift
//  NetworkLayerTests
//
//  Created by Irving Delgado Silva on 16/01/22.
//

import XCTest
import RxSwift
import RxCocoa
import RxBlocking

@testable import NetworkLayer

final class NetworkLayerTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    func testValidGetRequestFromURL() throws {
        // Given
        let sut = NetworkRequest(method: RequestMethod.GET, path: NetworkConstants.MockData.mockMovieEndpoint, parameters: NetworkConstants.MockData.mockMovieParameters, headers: NetworkConstants.MockData.mockHeaders)
        
        if let baseurl = URL(string: NetworkConstants.MockData.mockMovieBaseurl) {
            
            do {
                // When
                let urlRequest = try sut.getRequest(with: baseurl )
                
                // Then, assert
                XCTAssertEqual(urlRequest.httpMethod, sut.method.rawValue)
                
                let urlObject = try XCTUnwrap(urlRequest.url)

                XCTAssertEqual(urlObject.path, NetworkConstants.MockData.mockMovieEndpoint)
                XCTAssertEqual(sut.parameters, NetworkConstants.MockData.mockMovieParameters)
                
                // If there were any headers test if they were added correctly
                if let headersAttached = sut.headers {
                    XCTAssertEqual(headersAttached, NetworkConstants.MockData.mockHeaders)
                }
            } catch {
                XCTFail(error.localizedDescription)
            }
            
        } else {
            XCTFail("Can't create url from string")
        }

    }
    
    func testNetworkClientPerformValidRequestRX() {
        
        // Given
        if let url = URL(string: NetworkConstants.MockData.mockMovieBaseurl) {
            let sut = NetworkClient(baseURL: url)
            let request = NetworkRequest(method: RequestMethod.GET, path: NetworkConstants.MockData.mockMovieEndpoint, parameters: NetworkConstants.MockData.mockMovieParameters, headers: NetworkConstants.MockData.mockHeaders)
            
            // When
            do {
                // Assert mock model
                _ = try XCTUnwrap(
                    try Observable.of(request)
                            .flatMap({ mockrequest -> Observable<MockCodableModel> in
                                return try sut.performRequestAndDecode(networkRequest: mockrequest)
                            }).toBlocking().first()
                )
                
            } catch {
                XCTFail(error.localizedDescription)
            }
                        
        } else {
            XCTFail("Can't create url from string")
        }

    }

    func testNetworkClientPerformValidRequestNonRX() {
        // Given
        if let url = URL(string: NetworkConstants.MockData.mockMovieBaseurl) {
            let sut = NetworkClient(baseURL: url)
            let request = NetworkRequest(method: RequestMethod.GET, path: NetworkConstants.MockData.mockMovieEndpoint, parameters: NetworkConstants.MockData.mockMovieParameters, headers: NetworkConstants.MockData.mockHeaders)
            
            let expectation = self.expectation(description: "Waiting for perform call to complete.")
            var result: Result<MockCodableModel, NetworkError>?
            
            do {
                // When
                try sut.performRequestAndDecode(networkRequest: request) { (response: Result<MockCodableModel, NetworkError>) in
                    result = response
                    expectation.fulfill()
                }

                // Wait for expectation to finish
                waitForExpectations(timeout: 2) { error in
                    XCTAssertNil(error)
                    switch result {
                    case .success(let mockModel):
                        XCTAssertEqual(mockModel.page, 1)
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
