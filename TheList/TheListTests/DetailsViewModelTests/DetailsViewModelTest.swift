
import XCTest
@testable import TheList

class DetailsViewModelTests: XCTestCase {
    
    var viewModel: DetailsViewModelContract!
    var mockCoordinator: CoordinatorProtocol!
    var mockUseCase:DetailsUseCaseContract!
    var mockRepo: RepoModel!
    
    override func setUp() {
        super.setUp()
        // Mock dependencies
        mockCoordinator = MockCoordinator()
        mockUseCase = MockRepoDetailsUseCase()
        
        mockRepo = RepoModel(id: 1, name: "Repo 1", fullName: "Full Name 1", owner: nil, url: "http://example.com", createdAt: "")
        viewModel = DetailsViewModel(repoModel: mockRepo, coordinator: mockCoordinator, usecase: mockUseCase)
        
    }
    
    override func tearDown() {
        viewModel = nil
        mockCoordinator = nil
        mockRepo = nil
        mockUseCase = nil
        super.tearDown()
    }
    
    func testFetchRepoDetails_Success() {
        // Given
        let expectation = self.expectation(description: "Fetch Repo Details Successful")
        var capturedRepo: RepoDetailsModel?
        
        viewModel.dataHandler = { repo in
            capturedRepo = repo
            expectation.fulfill()
        }
        
        // When
        viewModel.fetchDetailsFollowers(withUrl: "http://example.com")
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(capturedRepo)
        XCTAssertEqual(capturedRepo?.name, mockRepo.name) // Adjust based on what you expect to capture
    }
    
    func testFetchDetails_EmptyData() {
        // Given
        let expectation = self.expectation(description: "Fetch Repos Empty Data")
        var capturedError: String?
        
        
        // Mocking empty response
        let mockUseCase = MockRepoDetailsUseCase()
        mockUseCase.shouldReturnEmptyResponse = true
        viewModel = DetailsViewModel(repoModel: mockRepo, coordinator: mockCoordinator, usecase: mockUseCase)
        
        // Assign an expectation to wait for error handling
        viewModel.errorHandler = { error in
            capturedError = error
            expectation.fulfill()
        }
        
        // When
        viewModel.fetchDetailsFollowers(withUrl: "http://example.com")
        
        // Then
        waitForExpectations(timeout: 5) { error in
            // Assert the capturedError within the completion handler
            XCTAssertEqual(capturedError, APIError.emptyData.errorMessage)
        }
    }
    
    func testNavigateBack() {
        let mockCoordinator = MockCoordinator()
        
        // Given
        var dismissCalled = false
        mockCoordinator.dismissAction = {
            dismissCalled = true
        }
        
        viewModel = DetailsViewModel(repoModel: mockRepo, coordinator: mockCoordinator, usecase: mockUseCase)
        
        // When
        viewModel.navigateBack()
        
        // Then
        XCTAssertTrue(dismissCalled)
    }
}

// Mock Coordinator for testing
class MockCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController = UINavigationController()
    var dismissAction: (() -> Void)?
    
    func start() {}
    func navigateToNextScreen(destination: DestinationScreens) {}
    func dismiss() {
        dismissAction?()
    }
    func navigateToRoot() {}
}

// Mock classes for dependencies
class MockRepoDetailsUseCase: DetailsUseCaseContract {
    
    var shouldReturnEmptyResponse = false
    func fetchRepoDetails(withUrl: String, completion: @escaping (Result<TheList.RepoDetailsModel?, TheList.APIError>) -> Void) {
        if shouldReturnEmptyResponse {
            completion(.success(nil))
        } else {
            let mockRepoDetails = RepoDetailsModel(login: "joe", avatarURL: "", name: "Repo 1", company: "", blog: "", location: "Cairo", email: "", twitterUsername: "", followers: 100, following: 5)
            completion(.success(mockRepoDetails))
        }
    }
}
