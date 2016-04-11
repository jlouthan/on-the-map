//
//  UdacityConvenience.swift
//  OnTheMap
//
//  Created by Jennifer Louthan on 4/10/16.
//  Copyright © 2016 JennyLouthan. All rights reserved.
//

import Foundation

// MARK: - UdacityClient (Convenient Resource Methods)

extension UdacityClient {
    
    //MARK: POST Convenience Methods
    
    func createSession(email: String, password: String, completionHandlerForCreateSession: (success: Bool, error: NSError?) -> Void) {
        
        //Creat the NSURL
        let url = udacityURLWithMethod(Methods.CreateSession)
        //Create dictionary for JSON body
        let JSONBody = [
            JSONBodyKeys.Udacity: [
                JSONBodyKeys.Username: email,
                JSONBodyKeys.Password: password
            ]
        ]
        
        //Make the request
        requestBuilder.taskForPOSTMethod(url, JSONBody: JSONBody) { (result, error) in
            
            guard error == nil else {
                completionHandlerForCreateSession(success: false, error: error)
                return
            }
            
            //Send the desired value(s) to completion handler
            if let account = result[JSONResponseKeys.Account] as? [String: AnyObject], let userId = account[JSONResponseKeys.UserId] as? String {
                self.userId = userId
                completionHandlerForCreateSession(success: true, error: nil)
            } else {
                completionHandlerForCreateSession(success: false, error: NSError(domain: "create session response parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse Create Session Response"]))
            }
            
        }
        
    }
    
}