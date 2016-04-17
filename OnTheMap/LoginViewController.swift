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
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginPressed(sender: AnyObject) {
        loginButton.enabled = false
        guard !emailField.text!.isEmpty && !passwordField.text!.isEmpty else {
            displayError("Missing required field")
            loginButton.enabled = true
            return
        }
        UdacityClient.sharedInstance().createSession(emailField.text!, password: passwordField.text!) { (success, error) in
            
            performUIUpdatesOnMain({
                if success {
                    print("success!")
                    self.completeLogin()
                } else {
                    var errorText: String?
                    if let errorDict = error!.userInfo[NSLocalizedDescriptionKey] as? [String: AnyObject] {
                        errorText = errorDict["error"] as? String
                    } else {
                        errorText = error!.userInfo[NSLocalizedDescriptionKey] as? String
                    }
                    self.displayError(errorText)
                    self.loginButton.enabled = true
                }
            })
            
        }
    }
    
    // MARK: Login
    
    private func completeLogin() {
        let controller = storyboard!.instantiateViewControllerWithIdentifier("MapNavigationController")
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
            
            let alert = UIAlertController(title: "Login Error", message: errorString, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    }
}