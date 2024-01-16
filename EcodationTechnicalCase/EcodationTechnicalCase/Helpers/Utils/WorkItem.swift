//
//  WorkItem.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 15.01.2024.
//

import Foundation


/// Kullanıcı yazmayı bıraktığında SearchBar'ın textDidChange methodunu tetiklemek için kullanılan sınıf.
final class WorkItem {
    
    private var pendingRequestWorkItem: DispatchWorkItem?
    
    /// İstenilen süre sonunda bloğu çalıştırmak için kullanılan fonksiyon.
    /// - Parameters:
    ///   - after: Çalıştırılacak işlemden önce beklenmesi gereken süre.
    ///   - block: Çalıştırılacak işlem.
    func perform(after: TimeInterval, _ block: @escaping () -> Void) {
        // Mevcut işlemi iptal et
        pendingRequestWorkItem?.cancel()
        
        // İsteğimizi bir iş öğesi içine alın
        let requestWorkItem = DispatchWorkItem(block: block)
        
        pendingRequestWorkItem = requestWorkItem
        
        // Belirtilen süre sonunda ana kuyruk üzerinde çalıştır
        DispatchQueue.main.asyncAfter(deadline: .now() + after, execute: requestWorkItem)
    }

}
