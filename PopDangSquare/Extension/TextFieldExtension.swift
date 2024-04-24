//
//  TextFieldExtension.swift
//  PopDangSquare
//
//  Created by 예슬 on 4/23/24.
//

import Foundation
import UIKit

extension UITextField {
  func setTextField(string: String) {
    clipsToBounds = true
    layer.cornerRadius = 15
    
    let attributes = [
      NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10)
    ]
    
    attributedPlaceholder = NSAttributedString(string: "   " + string, attributes: attributes)
  }
}
