//
//  ApplicationVariables.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//

import Foundation

struct ApplicationVariables {
    
    private static let defaults = UserDefaults.standard
    
    private init() {}
    
    /// Kullanıcının UID'sini saklayan değişken.
    static var currentUserID: String?{
        get{
            return defaults.string(forKey: "currentUserID")
        } set {
            defaults.set(newValue, forKey: "currentUserID")
        }
    }
    
    /// UserDefaults tutulan currentUserID temizler
    static func resetApplicationVariables(){
        defaults.removeObject(forKey: "currentUserID")
    }
}
