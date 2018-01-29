//
//  FeedbackAlert.swift
//  Movies
//
//  Created by Thiago Diniz on 25/01/2018.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import Foundation
import SwiftMessages

class FeedbackAlert {
    
    var config = SwiftMessages.Config()
    let body: String!
    var view = MessageView.viewFromNib(layout: .cardView)
    
    init(body: String, target: UIViewController) {
        config.presentationContext = .viewController(target)
        config.presentationStyle = .top
        self.body = body
    }
    
    private func setupLabels() {
        self.view.button?.isHidden = true
        self.view.iconLabel?.isHidden = true
        self.view.iconImageView?.isHidden = true
        self.view.titleLabel?.isHidden = true
        self.view.bodyLabel?.textColor = UIColor.white
        self.view.bodyLabel?.font = UIFont.systemFont(ofSize: 14)
        self.view.bodyLabel?.numberOfLines = 0
        self.view.bodyLabel?.text = self.body
    }
    
    private func showMessage(color: Color) {
        view.configureTheme(backgroundColor: color, foregroundColor: UIColor.white)
        self.setupLabels()
        SwiftMessages.show(config: config, view: view)
    }
    
    func showSuccess() {
        config.duration = .seconds(seconds: TimeInterval(exactly: 1)!)
        config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        config.presentationStyle = .bottom
        self.showMessage(color: ColorName.successAlert.color)
    }

    func showError() {
         self.showMessage(color: ColorName.errorsAlert.color)
    }
    
    func showErrorWindowContent() {
        config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        self.showError()
    }
}
