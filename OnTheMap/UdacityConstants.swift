//
//  UdacityConstants.swift
//  OnTheMap
//
//  Created by Jennifer Louthan on 4/10/16.
//  Copyright © 2016 JennyLouthan. All rights reserved.
//

import Foundation

extension UdacityClient {
    
    //MARK: Constants
    struct Constants {
        // MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "www.udacity.com"
        static let ApiPath = "/api"
    }
    
    //MARK: Methods
    struct Methods {
        static let CreateSession = "/session"
        static let DeleteSession = "/session"
        static let UserData = "/users/{userId}"
    }
    
    //MARKL URLKeys
    struct URLKeys {
        static let UserId = "userId"
    }
    
    // MARK: JSON Body Keys
    struct JSONBodyKeys {
        static let Udacity = "udacity"
        static let Username = "username"
        static let Password = "password"
    }
    
    //MARK: JSON Response Keys
    struct JSONResponseKeys {
        static let Account = "account"
        static let UserId = "key"
        static let User = "user"
        static let FirstName = "first_name"
        static let LastName = "last_name"
    }
    
    //MARK: Header Keys
    struct HeaderKeys {
        static let XSRFToken = "X-XSRF-TOKEN"
    }
}