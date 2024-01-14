//
//  SearchVC.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//

import UIKit

final class SearchVC: UIViewController {

    //MARK: - Properties
    private let searchView = SearchView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Load View
    override func loadView() {
        super.loadView()
        view = searchView
    }
 

}
