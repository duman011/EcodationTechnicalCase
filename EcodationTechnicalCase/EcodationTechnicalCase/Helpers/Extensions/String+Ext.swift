//
//  String+Ext.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//

import Foundation

extension String {
    
    /// Verilen email'in geçerli bir email olup olmadığını kontrol eder.
    func isValidEmail(email: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest  = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }
    
    /// Verilen şifrenin geçerli bir şifre olup olmadığını kontrol eder.
    /// Şifre en az bir büyük harf, bir küçük harf ve bir rakam içermelidir.
    func isValidPassword(password: String) -> Bool{
        let passwordRegEx = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{6,18}$"
        let passwordTest  = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        let result = passwordTest.evaluate(with: password)
        return result
    }
    
    /// Verilen metnin içerisinde en az bir rakam bulunup bulunmadığını kontrol eder.
    func containsDigits(_ value: String) -> Bool{
        let DigitsRegEx = ".*[0-9]+.*"
        let DigitsTest  = NSPredicate(format: "SELF MATCHES %@", DigitsRegEx)
        let result = DigitsTest.evaluate(with: value)
        return result
    }
    
    /// Verilen metnin içerisinde en az bir büyük harf bulunup bulunmadığını kontrol eder.
    func containsUpperCase(_ value: String) -> Bool{
        let UpperCaseRegEx = ".*[A-Z]+.*"
        let UpperCaseTest  = NSPredicate(format: "SELF MATCHES %@", UpperCaseRegEx)
        let result = UpperCaseTest.evaluate(with: value)
        return result
    }
    
    /// Verilen metnin içerisinde en az bir küçük harf bulunup bulunmadığını kontrol eder.
    func containsLowerCase(_ value: String) -> Bool{
        let LowerCaseRegEx = ".*[a-z]+.*"
        let LowerCaseTest  = NSPredicate(format: "SELF MATCHES %@", LowerCaseRegEx)
        let result = LowerCaseTest.evaluate(with: value)
        return result
    }
}
