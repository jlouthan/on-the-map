//
//  ParseConvenience.swift
//  OnTheMap
//
//  Created by Jennifer Louthan on 4/10/16.
//  Copyright © 2016 JennyLouthan. All rights reserved.
//

import Foundation

extension ParseClient {
    
    //MARK: GET Convenience Methods
    
    func getStudentLocations(completionHandlerForGetStudentLocations: (success: Bool, error: NSError?) -> Void) {
        
        //Creat the NSURL
        let parameters = [
            ParameterKeys.Limit: ParameterValues.DefaultLimit,
            ParameterKeys.Order: ParameterValues.DefaultOrder
        ]
        let url = parseURLWithMethod(parameters, methodPath: Methods.StudentLocations)
        
        //Make the request
        requestBuilder.taskForGETMethod(url, headers: Constants.CommonHeaders) { (result, error) in
            
            guard error == nil else {
                completionHandlerForGetStudentLocations(success: false, error: error)
                return
            }
            
            //Send the desired value(s) to completion handler
            if let studentLocationResults = result[ResponseKeys.StudentLocationResults] as? [[String: AnyObject]] {
                let studentInfo = StudentInformation.studentInfoFromResults(studentLocationResults)
                //Keep the current array of Student Information structs within the Parse Client
                self.studentInfo = studentInfo
                completionHandlerForGetStudentLocations(success: true, error: nil)
            } else {
                let error = NSError(domain: "getStudentLocations parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getStudentLocations response"])
                completionHandlerForGetStudentLocations(success: false, error: error)
            }
            
        }
        
    }
    
    func postStudentLocation(studentInfo: StudentInformation, completionHandlerForPostStudentLocation: (success: Bool, error: NSError?) -> Void) {
        
        //Create the NSURL
        let parameters = [String: AnyObject]()
        let url = parseURLWithMethod(parameters, methodPath: Methods.PostStudentLocation)
        
        //Create the jsonBody dictionary
        let jsonBody = [
            JSONBodyKeys.StudentId: studentInfo.id,
            JSONBodyKeys.FirstName: studentInfo.firstName,
            JSONBodyKeys.LastName: studentInfo.lastName,
            JSONBodyKeys.MapString: studentInfo.mapString,
            JSONBodyKeys.MediaURL: studentInfo.mediaURL,
            JSONBodyKeys.Latitude: studentInfo.latitude,
            JSONBodyKeys.Longitude: studentInfo.longitude,
        ]
        
        requestBuilder.taskForPOSTMethod(url, JSONBody: jsonBody as! [String: AnyObject], headers: Constants.CommonHeaders) { (result, error) in
            
            guard error == nil else {
                completionHandlerForPostStudentLocation(success: false, error: error)
                return
            }
            
            print(result)
            completionHandlerForPostStudentLocation(success: true, error: nil)
        }
        
    }
}