//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Jennifer Louthan on 4/10/16.
//  Copyright © 2016 JennyLouthan. All rights reserved.
//

import Foundation
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parentViewController!.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(MapViewController.logout))
        
        refreshMap()
    }
    
    //MARK: Refresh the map
    private func refreshMap() -> Void{
        
        ParseClient.sharedInstance().getStudentLocations { (success, error) in
            guard success && error == nil else {
                //TODO show error in UI somehow
                print(error)
                return
            }
            
            var annotations = [MKPointAnnotation]()
            
            //Create an annotation for each student location returned
            for studentInfo in ParseClient.sharedInstance().studentInfo {
                let annotation = MKPointAnnotation()
                annotation.title = "\(studentInfo.firstName) \(studentInfo.lastName)"
                annotation.subtitle = studentInfo.mediaURL
                let lat = CLLocationDegrees(studentInfo.latitude)
                let long = CLLocationDegrees(studentInfo.longitude)
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                annotations.append(annotation)
            }
            performUIUpdatesOnMain({
                self.mapView.addAnnotations(annotations)
            })
            
        }

    }
    
    //MARK: MKMapViewDelegate
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = UIColor.redColor()
            pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
        
    }
    
    
    //Open student link in Safari on pin tap
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            
            if let urlString = view.annotation?.subtitle!, let url = NSURL(string: urlString) {
                if UIApplication.sharedApplication().canOpenURL(url) {
                    UIApplication.sharedApplication().openURL(url)
                }
            }
            
        }
    }
    
    //MARK: Logout
    func logout() {
        //TODO actually log out here with Udacity client
        dismissViewControllerAnimated(true, completion: nil)
    }
}