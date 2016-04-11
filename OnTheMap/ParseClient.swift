//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Jennifer Louthan on 4/10/16.
//  Copyright © 2016 JennyLouthan. All rights reserved.
//

import Foundation

class ParseClient: NSObject {
    
    // shared request builder
    let requestBuilder = NetworkRequestBuilder.sharedInstance()
    
    //MARK: Helpers
    
    //create a URL from parameters and method
    func parseURLWithMethod(parameters: [String: AnyObject], methodPath: String? = nil) -> NSURL {
        let components = NSURLComponents()
        components.scheme = Constants.ApiScheme
        components.host = Constants.ApiHost
        components.path = Constants.ApiPath + (methodPath ?? "")
        
        components.queryItems = [NSURLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = NSURLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.URL!
    }
    
    //MARK: Shared Instance
    class func sharedInstance() -> ParseClient{
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }
}