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
    }
    
    //MARK: Methods
    struct Methods {
        static let StudentLocations = "/classes/StudentLocation"
    }
    
    //MARK: Parameter Keys
    struct ParameterKeys {
        static let Limit = "limit"
    }
    
    //MARK: Parameter Values 
    struct ParameterValues {
        static let DefaultLimit = "100"
    }
    
}