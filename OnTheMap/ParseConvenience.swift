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
            ParameterKeys.Limit: ParameterValues.DefaultLimit
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
                print(self.studentInfo)
                completionHandlerForGetStudentLocations(success: true, error: nil)
            } else {
                let error = NSError(domain: "getStudentLocations parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getStudentLocations response"])
                completionHandlerForGetStudentLocations(success: false, error: error)
            }
            
        }
        
    }
}