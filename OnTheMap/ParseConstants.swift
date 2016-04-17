//
//  ParseConstants.swift
//  OnTheMap
//
//  Created by Jennifer Louthan on 4/10/16.
//  Copyright © 2016 JennyLouthan. All rights reserved.
//

import Foundation

extension ParseClient {
    
    //MARK: Constants
    struct Constants {
        // MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "api.parse.com"
        static let ApiPath = "/1"
        //MARK: Common Headers
        static let CommonHeaders = [
            HeaderKeys.AppId: HeaderValues.AppId,
            HeaderKeys.APIKey: HeaderValues.APIKey
        ]
    }
    
    //MARK: Methods
    struct Methods {
        static let StudentLocations = "/classes/StudentLocation"
        static let PostStudentLocation = "/classes/StudentLocation"
    }
    
    //MARK: Parameter Keys
    struct ParameterKeys {
        static let Limit = "limit"
        static let Order = "order"
    }
    
    //MARK: Parameter Values 
    struct ParameterValues {
        static let DefaultLimit = "100"
        static let DefaultOrder = "-createdAt"
    }
    
    //MARK: Response Keys
    struct ResponseKeys {
        static let StudentFirstName = "firstName"
        static let StudentLastName = "lastName"
        static let StudentLatitude = "latitude"
        static let StudentLongitude = "longitude"
        static let StudentMediaURL = "mediaURL"
        static let StudentLocationResults = "results"
        static let StudentId = "uniqueKey"
        static let MapString = "mapString"
    }
    
    //MARK: JSON Body Keys
    struct JSONBodyKeys {
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let MediaURL = "mediaURL"
        static let MapString = "mapString"
        static let StudentId = "uniqueKey"
    }
    
    //MARK: Header Values {
    struct HeaderValues {
        static let AppId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let APIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    }
    
    //MARK: Header Keys {
    struct HeaderKeys {
        static let AppId = "X-Parse-Application-Id"
        static let APIKey = "X-Parse-REST-API-Key"
    }
    
}