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
        requestBuilder.taskForGETMethod(url) { (result, error) in
            
            guard error == nil else {
                completionHandlerForGetStudentLocations(success: false, error: error)
                return
            }
            
            print(result)
            
//            //Send the desired value(s) to completion handler
//            if let account = result[JSONResponseKeys.Account] as? [String: AnyObject], let userId = account[JSONResponseKeys.UserId] as? String {
//                self.userId = userId
//                completionHandlerForCreateSession(success: true, error: nil)
//            } else {
//                completionHandlerForCreateSession(success: false, error: NSError(domain: "create session response parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse Create Session Response"]))
//            }
            
        }
        
    }
}