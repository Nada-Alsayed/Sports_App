//
//  SportyXTests.swift
//  SportyXTests
//
//  Created by MAC on 24/05/2023.
//

import XCTest
@testable import SportyX
final class SportyXTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testLoadLeaguesListFromAPI(){
        let url = Names.getLeaguesUrl(sport: Names.FOOTBALL)
        let expectation = expectation(description: "wait for api")
        Network.loadData(urls: url) { result in
            if let result = result {
                XCTAssert(result.result.count > 0)
                print("league Name : \(result.result[0].leagueName ?? "")")
                expectation.fulfill()
            }
            else{
               XCTFail()
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 7)
    }
    
    func testLoadLeagueDetailsFromAPI(){
        let url = Names.getFixtureUrl(sport: Names.FOOTBALL, leagueID: 4, from: "2023-05-21",to: "2023-09-18")
        let expectation = expectation(description: "wait for api")
        Network.loadLeagueDataFromAPI(urls: url) { result in
            if let result = result {
                XCTAssert(result.result?.count ?? 0 > 0)
                print("league Name : \(result.result?[0].leagueName ?? "")")
                expectation.fulfill()
            }
            else{
               XCTFail()
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 7)
    }
    
    func testLoadTeamDetailsFromAPI(){
        let url = Names.getTeamDetails(sport: Names.FOOTBALL, teamId: 90)
        let expectation = expectation(description: "wait for api")
        Network.loadTeamsFromAPI(urls: url){ result in
            if let result = result {
                XCTAssert(result.result?.count ?? 0 > 0)
                print("Player Name : \(result.result?[0].players?[0].playerName ?? "")")
                expectation.fulfill()
            }
            else{
               XCTFail()
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 7)
    }
    
}
