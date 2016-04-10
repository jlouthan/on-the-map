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
    
    @IBAction func loginPressed(sender: AnyObject) {
        guard !emailField.text!.isEmpty && !passwordField.text!.isEmpty else {
            print("Missing required field")
            return
        }
        print("Got required fields \(emailField.text!) and \(passwordField.text!)")
    }
    
}