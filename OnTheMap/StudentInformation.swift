//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Jennifer Louthan on 4/11/16.
//  Copyright © 2016 JennyLouthan. All rights reserved.
//

import Foundation

// MARK: - StudentInformation

struct StudentInformation {
    
    //MARK: properties
    
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mediaURL: String
    let id: String
    let mapString: String
    
    //MARK: Initializers
    
    //Construct a student info struct from a dictionary
    init(dictionary: [String: AnyObject]) {
        firstName = dictionary[ParseClient.ResponseKeys.StudentFirstName] as! String
        lastName = dictionary[ParseClient.ResponseKeys.StudentLastName] as! String
        latitude = dictionary[ParseClient.ResponseKeys.StudentLatitude] as! Double
        longitude = dictionary[ParseClient.ResponseKeys.StudentLongitude] as! Double
        mediaURL = dictionary[ParseClient.ResponseKeys.StudentMediaURL] as! String
        id = dictionary[ParseClient.ResponseKeys.StudentId] as! String
        mapString = dictionary[ParseClient.ResponseKeys.MapString] as! String
    }
    
    static func studentInfoFromResults(results: [[String:AnyObject]]) -> [StudentInformation] {
        
        var studentInfo = [StudentInformation]()
        for res in results {
            studentInfo.append(StudentInformation(dictionary: res))
        }
        
        return studentInfo
        
    }
}