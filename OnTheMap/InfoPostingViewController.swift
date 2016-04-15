//
//  InfoPostingViewController.swift
//  OnTheMap
//
//  Created by Jennifer Louthan on 4/13/16.
//  Copyright © 2016 JennyLouthan. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class InfoPostingViewController: UIViewController {
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var findOnMapButton: UIButton!
    @IBOutlet weak var mediaLinkTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: Submission State
    var mapString: String?
    var pinLocation: CLLocationCoordinate2D?
    
    //MARK: Life Cycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        initUI()
    }
    
    private func initUI() {
        mediaLinkTextField.hidden = true
        submitButton.hidden = true
        locationTextField.hidden = false
        findOnMapButton.hidden = false
        findOnMapButton.enabled = true
    }
    
    @IBAction func findOnMapPressed(sender: AnyObject) {
        guard !locationTextField.text!.isEmpty else {
            print("Missing Required field")
            return
        }
        findOnMapButton.enabled = false
        findOnMapButton.hidden = true
        locationTextField.hidden = true
        handleLocationString(locationTextField.text!)
    }
    
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
    
    private func handleLocationString(locationString: String) {
        //TODO "display activity" here
        CLGeocoder().geocodeAddressString(locationString) { (placemarks, error) in
            guard error == nil else {
                print(error)
                return
            }
            if let placemark = placemarks?.first {
                //Set pinLocation to proper coordinate and display on a map view
                self.pinLocation = placemark.location!.coordinate
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = self.pinLocation!
                self.mapView.hidden = false
                self.mapView.addAnnotation(annotation)
            }
        }
    }
}