
import XCTest
@testable import TheList

class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModelContract!
    var mockCoordinator:CoordinatorProtocol!
    var mockUseCase:RepoListUseCaseContract!
    override func setUp() {
        super.setUp()
        // Mock dependencies
        mockCoordinator = AppCoordinator(navigationController: UINavigationController())
        mockUseCase = MockRepoListUseCase()
        viewModel = HomeViewModel(coordinator: mockCoordinator , usecase: mockUseCase)
    }
    
    override func tearDown() {
        viewModel = nil
        mockCoordinator = nil
        mockUseCase = nil
        super.tearDown()
    }
    
    func testFetchRepos_Success() {
        // Given
        let expectation = self.expectation(description: "Fetch Repos Successfully")
        var capturedRepos: [RepoModel]?
        
        viewModel.dataHandler = { repos in
            capturedRepos = repos
            expectation.fulfill()
        }
        
        // When
        viewModel.fetchRepos()
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(capturedRepos)
        XCTAssertEqual(capturedRepos?.count, 2) // Adjust this based on your mocked response
    }
    
    func testFetchRepos_EmptyData() {
        // Given
        let expectation = self.expectation(description: "Fetch Repos Empty Data")
        var capturedError: String?
        
        
        // Mocking empty response
        let mockUseCase = MockRepoListUseCase()
        mockUseCase.shouldReturnEmptyResponse = true
        viewModel = HomeViewModel(coordinator: mockCoordinator, usecase: mockUseCase)
        
        // Assign an expectation to wait for error handling
        viewModel.errorHandler = { error in
            capturedError = error
            expectation.fulfill()
        }
        
        // When
        viewModel.fetchRepos()
        
        // Then
        waitForExpectations(timeout: 5) { error in
            // Assert the capturedError within the completion handler
            XCTAssertEqual(capturedError, APIError.emptyData.errorMessage)
        }
    }
}

// Mock classes for dependencies
class MockRepoListUseCase: RepoListUseCaseContract {
    
    var shouldReturnEmptyResponse = false
    
    func fetchRepos(completion: @escaping (Result<[RepoModel]?, APIError>) -> Void) {
        if shouldReturnEmptyResponse {
            completion(.success(nil))
        } else {
            let mockRepo1 = RepoModel(id: 1, name: "Repo 1", fullName: "Full Name 1", owner: nil, url: "", createdAt: "")
            let mockRepo2 = RepoModel(id: 2, name: "Repo 2", fullName: "Full Name 2", owner: nil, url: "", createdAt: "")
            completion(.success([mockRepo1, mockRepo2]))
        }
    }
}
