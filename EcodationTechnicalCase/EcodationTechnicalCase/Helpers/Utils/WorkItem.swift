//
//  WorkItem.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 15.01.2024.
//

import Foundation

///  SearchBar'ın textDidChange methodunu her harf girişinde değil de, kullanıcı yazmayı bıraktığında tetiklemek için kullandığımız class.
final class WorkItem {
    
    private var pendingRequestWorkItem: DispatchWorkItem?
    
    func perform(after: TimeInterval, _ block: @escaping () -> Void) {
        // Cancel the currently pending item
        pendingRequestWorkItem?.cancel()
        
        // Wrap our request in a work item
        let requestWorkItem = DispatchWorkItem(block: block)
        
        pendingRequestWorkItem = requestWorkItem
        
        DispatchQueue.main.asyncAfter(deadline: .now() + after, execute: requestWorkItem)
    }
}
