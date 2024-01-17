//
//  MockWatchListVC.swift
//  EcodationTechnicalCaseTests
//
//  Created by Yaşar Duman on 17.01.2024.
//

@testable import EcodationTechnicalCase
import UIKit

final class MockWatchListVC: WatchListVCInterface {
    var invokedConfigureNavbar = false
    var invokedConfigureNavbarCount = 0
  
    func configureNavbar() {
        invokedConfigureNavbar = true
        invokedConfigureNavbarCount += 1
    }
    
    var invokedPrepareTableView = false
    var invokedPrepareTableViewCount = 0

    func prepareTableView() {
        invokedPrepareTableView = true
        invokedPrepareTableViewCount += 1
    }
    
    var invokedTableViewReloadData = false
    var invokedTableViewReloadDataCount = 0
    
    func tableViewReloadData() {
        invokedTableViewReloadData = true
        invokedTableViewReloadDataCount += 1
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
