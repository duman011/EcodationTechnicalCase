//
//  CustomTextField.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 12.01.2024.
//

import UIKit

final class CustomTextField: UITextField {
    
    enum CustomTextFieldType {
        case email
        case password
    }
    
    private lazy var rightButton  = UIButton(configuration: .plain())
    private let authField: CustomTextFieldType
    
    init(fieldType: CustomTextFieldType) {
        self.authField = fieldType
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
  
        backgroundColor           = UIColor.loginTextFieldBG
        layer.cornerRadius        = 5
        //layer.borderWidth         = 2
        //layer.borderColor         = UIColor.darkBlue.cgColor
        textColor                 = .black
        tintColor                 = .black
        textAlignment             = .left
        
        //Changing Placeholder Text Color
        attributedPlaceholder = NSAttributedString(
            string: "Placeholder Text",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        
        adjustsFontSizeToFitWidth = true
        minimumFontSize           = 12
        leftViewMode              = .always
        leftView                  = UIView(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: 12,
                                                         height:frame.size.height))
        
        self.returnKeyType = .done
        // Klavyenin "Return" (veya "Done") düğmesinin işlevini belirler. .done, klavyede "Done" düğmesini gösterir ve genellikle bir metin girişi işlemi tamamlandığında kullanılır.
        
        self.autocorrectionType = .no
        // Otomatik düzeltme işlemini denetler. .no, otomatik düzeltme özelliğini devre dışı bırakır. Bu, kullanıcının metin girişi yaparken yazım hatalarının düzeltilmesini önler.
        
        self.autocapitalizationType = .none
        // Otomatik büyük harf dönüşümünü yönetir. .none, otomatik büyük harf dönüşümünü devre dışı bırakır, yani kullanıcı tarafından girilen metin tamamen küçük harfle kalır.
        
        
        switch fieldType {
        case .email:
            self.placeholder  = "Email address"
            self.keyboardType = .emailAddress
            // Klavye türünü belirler. .emailAddress, kullanıcının bir e-posta adresi girmesi gerektiğini belirten bir klavye türüdür. Bu, klavyede @ sembolü ve diğer e-posta adresi karakterlerini kolayca erişilebilir hale getirir.
            
            self.textContentType = .emailAddress
            // Metin içeriği türünü belirler. .emailAddress, metin girişi sırasında otomatik tamamlama ve önerileri etkinleştirir ve kullanıcının e-posta adresi girmesini kolaylaştırır. Örneğin, daha önce kullanılan e-posta adreslerini önerme yeteneği gibi özellikleri içerebilir.
            
        case .password:
            self.placeholder       = "Password"
            self.textContentType   = .password
            self.isSecureTextEntry = true
            
            rightButton.setImage(UIImage(systemName: "eye.slash.fill") , for: .normal)
            rightButton.addTarget(self, action: #selector(toggleShowHide), for: .touchUpInside)            
            rightButton.frame = CGRect(x:0, y:0, width:30, height:30)
             
            rightViewMode = .always
            rightView = rightButton
        }
    }
    
    @objc private func toggleShowHide(button: UIButton) {
        toggle()
    }
    
    private func toggle() {
        isSecureTextEntry = !isSecureTextEntry
        if isSecureTextEntry {
            rightButton.setImage(UIImage(systemName: "eye.slash.fill") , for: .normal)
        } else {
            rightButton.setImage(UIImage(systemName: "eye.fill") , for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
