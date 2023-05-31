
import XCTest
@testable import SportyX


final class testPlayersViewModel: XCTestCase {
    var viewModel : PlayersViewModel! = nil
    override func setUpWithError() throws {
        viewModel = PlayersViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testGetData(){
        viewModel.bindResultToViewController3 = {result in
            XCTAssert(result.count > 0)
        }
        viewModel.getLeagueTeams(url: Names.getTeamDetails(sport: "football", teamId: 90))
    }
}
