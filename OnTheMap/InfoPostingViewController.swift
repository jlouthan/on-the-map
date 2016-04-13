//
//  InfoPostingViewController.swift
//  OnTheMap
//
//  Created by Jennifer Louthan on 4/13/16.
//  Copyright © 2016 JennyLouthan. All rights reserved.
//

import Foundation
import UIKit

class InfoPostingViewController: UIViewController {
    @IBOutlet weak var textInput: UITextField!
    
    @IBAction func submitPressed(sender: AnyObject) {
        let currentStudentDict = [
            ParseClient.ResponseKeys.StudentFirstName: UdacityClient.sharedInstance().userFirstName!,
            ParseClient.ResponseKeys.StudentLastName: UdacityClient.sharedInstance().userLastName!,
            //dummy values for not. get from UI later
            ParseClient.ResponseKeys.StudentLatitude: 45.523452,
            ParseClient.ResponseKeys.StudentLongitude: -122.676207,
            ParseClient.ResponseKeys.StudentMediaURL: "https://www.reddit.com/r/portland",
            ParseClient.ResponseKeys.StudentId: UdacityClient.sharedInstance().userId!,
            ParseClient.ResponseKeys.MapString: "Portland, OR"
        ] as [String: AnyObject]
        
        let currentStudent = StudentInformation(dictionary: currentStudentDict)
        print(currentStudent)
    }
}