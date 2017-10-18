//
//  MainVC.swift
//  TrendingSocial
//
//  Created by Kirk Washam on 10/17/17.
//  Copyright © 2017 StudioATX. All rights reserved.
//

import UIKit
import AWSAuthUI
import AWSUserPoolsSignIn
import AWSFacebookSignIn

class MainVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if !AWSSignInManager.sharedInstance().isLoggedIn {
            
            presentAuthUIViewController()
        }
      
        
    }

    func presentAuthUIViewController() {
        let config = AWSAuthUIConfiguration()
        config.enableUserPoolsUI = true
        config.addSignInButtonView(class: AWSFacebookSignInButton.self)
        
        // you can use properties like logoImage, backgroundColor to customize screen
        config.canCancel = false // prevent end user dismissal of the sign in screen
        
        // you should have a navigation controller for your view controller
        // the sign in screen is presented using the navigation controller
        
        AWSAuthUIViewController.presentViewController(
            with: navigationController!,  // put your navigation controller here
            configuration: config,
            completionHandler: {(
                _ signInProvider: AWSSignInProvider, _ error: Error?) -> Void in
                if error == nil {
                    DispatchQueue.main.async(execute: {() -> Void in
                        // handle successful callback here,
                        // e.g. pop up to show successful sign in
                    })
                    
                }
                else {
                    // end user faced error while loggin in,
                    // take any required action here
                }
        })
    }
}
