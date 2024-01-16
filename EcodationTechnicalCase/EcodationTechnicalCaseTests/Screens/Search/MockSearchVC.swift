//
//  MockSearchVC.swift
//  EcodationTechnicalCaseTests
//
//  Created by Yaşar Duman on 16.01.2024.
//

@testable import EcodationTechnicalCase
import UIKit

final class MockSearchVC: SearcVCInterface {
    var invokedConfigureNavigationBar = false
    var invokedConfigureNavigationBarCount = 0
  
    func configureNavigationBar() {
        invokedConfigureNavigationBar = true
        invokedConfigureNavigationBarCount += 1
    }
    
    var invokedPrepareSearchTableView = false
    var invokedPrepareSearchTableViewCount = 0

    func prepareSearchTableView() {
        invokedPrepareSearchTableView = true
        invokedPrepareSearchTableViewCount += 1
    }
    
    var invokedSearchTableViewReloadData = false
    var invokedSearchTableViewReloadDataCount = 0
    
    func searchTableViewReloadData() {
        invokedSearchTableViewReloadData = true
        invokedSearchTableViewReloadDataCount += 1
    }
    
    var invokedPushVC = false
    var invokedPushVCCount = 0
    var invokedPushVCParameters: (vc: UIViewController, Void)?
    var invokedPushVCParametersList = [(vc: UIViewController, Void)]()
    
    func pushVC(vc: UIViewController) {
        invokedPushVC = true
        invokedPushVCCount += 1
        invokedPushVCParameters = (vc: vc, ())
        invokedPushVCParametersList.append((vc: vc, ()))
    }
}
