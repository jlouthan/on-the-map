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
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var findOnMapButton: UIButton!
    @IBOutlet weak var mediaLinkTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //MARK: Submission State
    var mapString: String = ""
    var pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    //MARK: Life Cycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        initUI()
    }
    
    private func initUI() {
        performUIUpdatesOnMain {
            self.spinner.hidden = true
            self.mediaLinkTextField.hidden = true
            self.submitButton.hidden = true
            self.locationLabel.hidden = false
            self.locationTextField.hidden = false
            self.locationTextField.text = nil
            self.findOnMapButton.hidden = false
            self.findOnMapButton.enabled = true
        }
    }
    
    @IBAction func findOnMapPressed(sender: AnyObject) {
        guard !locationTextField.text!.isEmpty else {
            displayError("Please enter a location name")
            return
        }
        findOnMapButton.enabled = false
        findOnMapButton.hidden = true
        locationTextField.hidden = true
        locationLabel.hidden = true
        spinner.hidden = false
        handleLocationString(locationTextField.text!)
    }
    
    @IBAction func submitPressed(sender: AnyObject) {
        guard !mediaLinkTextField.text!.isEmpty else {
            displayError("Please enter a link to associate with your location")
            return
        }
        submitButton.enabled = false
        
        let currentStudentDict = [
            ParseClient.ResponseKeys.StudentFirstName: UdacityClient.sharedInstance().userFirstName!,
            ParseClient.ResponseKeys.StudentLastName: UdacityClient.sharedInstance().userLastName!,
            ParseClient.ResponseKeys.StudentLatitude: pinLocation.latitude,
            ParseClient.ResponseKeys.StudentLongitude: pinLocation.longitude,
            ParseClient.ResponseKeys.StudentMediaURL: mediaLinkTextField.text!,
            ParseClient.ResponseKeys.StudentId: UdacityClient.sharedInstance().userId!,
            ParseClient.ResponseKeys.MapString: mapString
        ] as [String: AnyObject]
        
        let currentStudent = StudentInformation(dictionary: currentStudentDict)
        ParseClient.sharedInstance().postStudentLocation(currentStudent) { (success, error) in
            performUIUpdatesOnMain({ 
                self.submitButton.enabled = true
            })
            guard error == nil else {
                self.displayError(error!)
                return
            }
            self.dismiss()
        }
    }
    
    private func handleLocationString(locationString: String) {
        spinner.startAnimating()
        CLGeocoder().geocodeAddressString(locationString) { (placemarks, error) in
            self.spinner.stopAnimating()
            self.spinner.hidden = true
            guard error == nil else {
                self.displayError("The location you entered could not be geocoded. Please try again.")
                self.initUI()
                return
            }
            if let placemark = placemarks?.first {
                //Set pinLocation to proper coordinate and display on a map view
                self.pinLocation = placemark.location!.coordinate
                self.mapString = locationString
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = self.pinLocation
                self.mapView.hidden = false
                self.mapView.addAnnotation(annotation)
                let region = MKCoordinateRegionMakeWithDistance(self.pinLocation, 2000, 2000)
                self.mapView.setRegion(region, animated: true)
                
                self.mediaLinkTextField.hidden = false
                self.submitButton.hidden = false
            }
        }
    }
    
    private func displayError(errorString: String) {
        performUIUpdatesOnMain {
            let alert = UIAlertController(title: "Error Creating Location", message: errorString, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    private func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelPressed(sender: AnyObject) {
        dismiss()
    }
}