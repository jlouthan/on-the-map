//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Jennifer Louthan on 4/10/16.
//  Copyright © 2016 JennyLouthan. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginPressed(sender: AnyObject) {
        guard !emailField.text!.isEmpty && !passwordField.text!.isEmpty else {
            displayError("Missing required field")
            return
        }
        UdacityClient.sharedInstance().createSession(emailField.text!, password: passwordField.text!) { (success, error) in
            
            //TODO handle or display error better here
            performUIUpdatesOnMain({
                if success {
                    print("success!")
                    self.completeLogin()
                } else {
                    let errorText = error!.userInfo[NSLocalizedDescriptionKey] as? String
                    self.displayError(errorText)
                }
            })
            
        }
    }
    
    // MARK: Login
    
    private func completeLogin() {
//        let controller = storyboard!.instantiateViewControllerWithIdentifier("ManagerNavigationController") as! UINavigationController
        let controller = storyboard!.instantiateViewControllerWithIdentifier("TabBarController")
        presentViewController(controller, animated: true, completion: nil)
    }
    
}

// MARK: - LoginViewController (Configure UI)

extension LoginViewController {
    
    private func setUIEnabled(enabled: Bool) {
        loginButton.enabled = enabled
        
        // adjust login button alpha
        if enabled {
            loginButton.alpha = 1.0
        } else {
            loginButton.alpha = 0.5
        }
    }
    
    private func displayError(errorString: String?) {
        if let errorString = errorString {
            errorLabel.text = errorString
        }
    }
}