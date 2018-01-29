//
//  UIViewController.swift
//  Movies
//
//  Created by Thiago Diniz on 25/01/2018.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    open override func awakeFromNib() {
        super.awakeFromNib()
        self.view.backgroundColor = ColorName.background.color
    }
    
    func handleError(_ errorType: APIError, target: UIViewController) {
        switch errorType {
        case .canceled, .other, .notFound:
            print(errorType.description)
            break
        case .noInternet, .serverError:
            FeedbackAlert(body: errorType.description, target: target).showErrorWindowContent()
            break
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
