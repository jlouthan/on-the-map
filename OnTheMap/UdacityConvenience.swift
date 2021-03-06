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
    
    //Login
    func createSession(email: String, password: String, completionHandlerForCreateSession: (success: Bool, error: String?) -> Void) {
        
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
        requestBuilder.taskForPOSTMethod(url, JSONBody: JSONBody, headers: [String:String]()) { (result, error) in
            
            guard error == nil else {
                completionHandlerForCreateSession(success: false, error: error)
                return
            }
            
            //Send the desired value(s) to completion handler
            if let account = result[JSONResponseKeys.Account] as? [String: AnyObject], let userId = account[JSONResponseKeys.UserId] as? String {
                self.userId = userId
                self.getUserInfo(userId, completionHandlerForGetUserInfo: { (result, error) in
                    guard error == nil else {
                        completionHandlerForCreateSession(success: false, error: error)
                        return
                    }
                    if let firstName = result[JSONResponseKeys.FirstName] as? String, let lastName = result[JSONResponseKeys.LastName] as? String {
                        self.userFirstName = firstName
                        self.userLastName = lastName
                    }
                    completionHandlerForCreateSession(success: true, error: nil)
                });
            } else {
                completionHandlerForCreateSession(success: false, error: "Error parsing Create Session Response")
            }
            
        }
        
    }
    
    
    //Logout
    func deleteCurrentSession(completionHandlerForDeleteSession: (success: Bool, error: String?) -> Void) {
        //Create the URL
        let url = udacityURLWithMethod(Methods.DeleteSession)
        
        //Look for cookie to set proper header
        var headers = [String: String]()
        var xsrfCookie: NSHTTPCookie? = nil
        let sharedCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            headers[HeaderKeys.XSRFToken] = xsrfCookie.value
        }
        
        requestBuilder.taskForDELETEMethod(url, headers: headers) { (result, error) in
            guard error == nil else {
                completionHandlerForDeleteSession(success: false, error: error)
                return
            }
            completionHandlerForDeleteSession(success: true, error: nil)
        }
        
    }
    
    //Get current user info
    func getUserInfo(userId: String, completionHandlerForGetUserInfo: (result: AnyObject!, error: String?) -> Void) {
        //Create the URL
        let url = udacityURLWithMethod(requestBuilder.subtituteKeyInMethod(Methods.UserData, key: URLKeys.UserId, value: userId))
        requestBuilder.taskForGETMethod(url, headers: [String:String]()) { (result, error) in
            
            guard error == nil else {
                completionHandlerForGetUserInfo(result: nil, error: error)
                return
            }
            if let userInfo = result[JSONResponseKeys.User] as? [String: AnyObject] {
                completionHandlerForGetUserInfo(result: userInfo, error: nil)
            } else {
                completionHandlerForGetUserInfo(result: nil, error: "Error parsing Get User Info Response")
            }
            
        }
    }
    
}