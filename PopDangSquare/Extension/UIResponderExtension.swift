//
//  UIResponderExtension.swift
//  PopDangSquare
//
//  Created by 예슬 on 4/24/24.
//

import Foundation
import UIKit

extension UIResponder {

    private static weak var firstResponder: UIResponder?

    static var currentFirstResponder: UIResponder? {
        firstResponder = nil
        
        // Send action to first responder
        // If target is nil, the app sends the message to the first responder
        UIApplication.shared.sendAction(
            #selector(UIResponder.findFirstResponder(_:)),
            to: nil,
            from: nil,
            for: nil)

        return firstResponder
    }

    @objc func findFirstResponder(_ sender: Any) {
        // The first responder assigns self to this private var
        UIResponder.firstResponder = self
    }
}
