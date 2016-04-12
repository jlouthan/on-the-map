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
        //get and add annotations here? Maybe get them in view will appear?
        
        //Add a test annotation
        var annotations = [MKPointAnnotation]()
        
        let lat = CLLocationDegrees(35.6528)
        let long = CLLocationDegrees(-97.4777778)
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        let annotation = MKPointAnnotation()
        annotation.title = "Test Annotation"
        annotation.subtitle = "www.example.com"
        annotation.coordinate = coordinate
        
        annotations.append(annotation)
        
        mapView.addAnnotations(annotations)
        
        //Test getting the locations here for now
        ParseClient.sharedInstance().getStudentLocations { (success, error) in
            guard success && error == nil else {
                //TODO show error in UI somehow
                print(error)
                return
            }
            print("success")
            
        }
    
    }
    
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
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
//    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        if control == view.rightCalloutAccessoryView {
//            let app = UIApplication.sharedApplication()
//            if let toOpen = view.annotation?.subtitle! {
//                app.openURL(NSURL(string: toOpen)!)
//            }
//        }
//    }
}