//
//  MockingTests.swift
//  SportyXTests
//
//  Created by MAC on 24/05/2023.
//

import XCTest

final class MockingTests: XCTestCase {
    var fakeObj = FakeNetwork(returnError: false)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testData(){
        fakeObj.loadData(urls: "") { league in
            if let league = league?.first {
                print("League Name : \(league["league_name"])")
                XCTAssertNotNil(league)
            }
            else{
                XCTFail()
            }
        }
    }
}
