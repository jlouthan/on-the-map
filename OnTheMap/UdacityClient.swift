//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Jennifer Louthan on 4/10/16.
//  Copyright © 2016 JennyLouthan. All rights reserved.
//

import Foundation

class UdacityClient: NSObject {
    
    // authentication state
    var userId: String? = nil
    var userFirstName: String? = nil
    var userLastName: String? = nil
    
    // shared request builder
    let requestBuilder = NetworkRequestBuilder.sharedInstance()
    
    //MARK: Helpers
    
    //create a URL from parameters and method
    func udacityURLWithMethod(methodPath: String? = nil) -> NSURL {
        let components = NSURLComponents()
        components.scheme = Constants.ApiScheme
        components.host = Constants.ApiHost
        components.path = Constants.ApiPath + (methodPath ?? "")
        
        return components.URL!
    }
    
    //MARK: Shared Instance
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
}