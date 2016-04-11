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
    
    @IBAction func loginPressed(sender: AnyObject) {
        guard !emailField.text!.isEmpty && !passwordField.text!.isEmpty else {
            print("Missing required field")
            return
        }
        UdacityClient.sharedInstance().createSession(emailField.text!, password: passwordField.text!) { (success, error) in
            
            //TODO handle or display error better here
            if success {
                print("success!")
            } else {
                if let errorText = error!.userInfo[NSLocalizedDescriptionKey] as? String {
                    performUIUpdatesOnMain({ 
                        self.errorLabel.text = errorText
                    })
                }
            }
            
        }
    }
    
}