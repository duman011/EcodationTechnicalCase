//
//  WatchListVMTest.swift
//  EcodationTechnicalCaseTests
//
//  Created by Yaşar Duman on 17.01.2024.
//

import XCTest
@testable import EcodationTechnicalCase

final class WatchListVMTest: XCTestCase {
    private var viewModel: WatchListViewModel!
    private var view: MockWatchListVC!
    private var firestoreManager: MockFirestoreManager!
    
    override func setUp() {//testlere başlamadan önce bu çalışacak
        // Test senaryosu için başlangıç durumunu ayarla
        super.setUp()
        view = .init()
        firestoreManager = .init()
        viewModel = .init(view: view,
                          firestoreManager: firestoreManager)
    }
    
    override func tearDown() {//test tamamlandıktan sonra çalışır.
        // Test tamamlandıktan sonra temizlik yap
        view = nil
        viewModel = nil
        firestoreManager = nil
        super.tearDown()
    }
    
    func test_viewDidLoad_InvokesRequiredMethods() {
        //given
        XCTAssertFalse(view.invokedConfigureNavbar)
        XCTAssertFalse(view.invokedPrepareTableView)
        
        //when
        viewModel.viewDidLoad()
        
        //then
        XCTAssertTrue(view.invokedConfigureNavbar)
        XCTAssertTrue(view.invokedPrepareTableView)
    }
    
    func test_deleteSwipeAction_InvokesRequiredMethods() {
        //given
        XCTAssertEqual(firestoreManager.invokedRemoveFromWatchListCount, 0)
        XCTAssertTrue(firestoreManager.invokedRemoveFromWatchListParametersList.isEmpty)
        XCTAssertEqual(view.invokedTableViewReloadDataCount, 0)
        
        //when
        viewModel.movies = [MockData.mockMovie]
        viewModel.deleteSwipeAction(at: IndexPath(row: 0, section: 0))
        
        //then
        XCTAssertEqual(firestoreManager.invokedRemoveFromWatchListCount, 1)
        XCTAssertTrue(firestoreManager.invokedRemoveFromWatchListParametersList.map(\.movie) is [Movie])
        XCTAssertEqual(view.invokedTableViewReloadDataCount, 1)
    }
    
    func test_didSelectRowAt_InvokesRequiredMethods() {
        //given
        XCTAssertEqual(view.invokedPushVCCount, 0)
        XCTAssertTrue(view.invokedPushVCParametersList.isEmpty)
        
        //when
        viewModel.movies = [MockData.mockMovie]
        viewModel.didSelectRowAt(at: IndexPath(row: 0, section: 0))
        
        //then
        XCTAssertEqual(view.invokedPushVCCount, 1)
        XCTAssertTrue(view.invokedPushVCParametersList.map(\.vc) is [DetailVC])
    }
    
    func test_refreshUI_tableViewReloadData(){
        //given
        XCTAssertEqual(view.invokedTableViewReloadDataCount, 0)
        
        //when
        viewModel.refreshUI()
        
        //then
        XCTAssertEqual(view.invokedTableViewReloadDataCount, 1)
    }
    
    func test_removeFromFavorites_InvokesRequiredMethods() {
        //given
        XCTAssertEqual(firestoreManager.invokedRemoveFromWatchListCount, 0)
        
        //when
        viewModel.removeMovieFromWatchList(movies: MockData.mockMovie)
        
        //then
        XCTAssertEqual(firestoreManager.invokedRemoveFromWatchListCount, 1)
    }
    
}
