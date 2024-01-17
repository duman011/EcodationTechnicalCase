//
//  SearchVMTests.swift
//  EcodationTechnicalCaseTests
//
//  Created by Yaşar Duman on 16.01.2024.
//

import XCTest
@testable import EcodationTechnicalCase

final class SearchVMTests: XCTestCase {
    private var viewModel: SearchViewModel!
    private var view: MockSearchVC!
    private var networkService: MockNetworkService!
  
    
    override func setUp() {//testlere başlamadan önce bu çalışacak
        // Test senaryosu için başlangıç durumunu ayarla
        super.setUp()
        view = .init()
        networkService = .init()
    
        viewModel = .init(view: view,
                          networkService: networkService)
    }
    
    override func tearDown() {//test tamamlandıktan sonra çalışır.
        // Test tamamlandıktan sonra temizlik yap
        view = nil
        viewModel = nil
        networkService = nil
        super.tearDown()
    }
    
    // Test senaryosu: viewDidLoad metodunun gerekli metodları çağırması
    func test_viewDidLoad_InvokesRequiredMethods() {
        //given
        XCTAssertEqual(view.invokedConfigureNavigationBarCount, 0)
        XCTAssertEqual(view.invokedPrepareSearchTableViewCount, 0)
        
        //when
        viewModel.viewDidLoad()
        
        //then
        XCTAssertEqual(view.invokedConfigureNavigationBarCount, 1)
        XCTAssertEqual(view.invokedPrepareSearchTableViewCount, 1)
    }
    
    
    // Test senaryosu: movieDidSelectItem metodunun gerekli metodları çağırması
    func test_movieDidSelectItem_InvokesRequiredMethods(){
        //given
        XCTAssertEqual(view.invokedPushVCCount, 0)
        XCTAssertTrue(view.invokedPushVCParametersList.isEmpty)
        
        //when
        viewModel.movies = [MockData.mockMovie]
        viewModel.movieDidSelectItem(at: IndexPath(row: 0, section: 0))
        
      
        // Then: pushVC metodunun bir kez çağrıldığı ve parametre listesinin bir DetailVC içerdiği kontrol edilir
        XCTAssertEqual(view.invokedPushVCCount, 1)
        XCTAssertTrue(view.invokedPushVCParametersList.map(\.vc) is [DetailVC])
    }
}
