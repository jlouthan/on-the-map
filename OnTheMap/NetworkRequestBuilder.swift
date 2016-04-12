//
//  NetworkRequestBuilder.swift
//  OnTheMap
//
//  Created by Jennifer Louthan on 4/10/16.
//  Copyright © 2016 JennyLouthan. All rights reserved.
//

import Foundation

class NetworkRequestBuilder: NSObject {
    
    var session = NSURLSession.sharedSession()
    
    
    //MARK: Generic GET Request
    func taskForGETMethod (url: NSURL, headers: [String: String], completionHandlerForGET: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        //Accepting a ready-build url, so we start here
        let request = NSMutableURLRequest(URL: url)
        //Add any headers
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        //Make the request
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(result: nil, error: NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            //Parse the data and use the data (happens in completion handler) */
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGET)
        }
        
        //Start the request
        task.resume()
        
        return task
    }
    
    // MARK: POST
    
    func taskForPOSTMethod (url: NSURL, JSONBody: [String: AnyObject], headers: [String: String], completionHandlerForPOST: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        //Accepting a ready-build url, so we start here
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //Add any additional headers
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(JSONBody, options: .PrettyPrinted)
        
        //Make the request
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForPOST(result: nil, error: NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            //For now, specialize for Udacity API. TODO fix this
            let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                //Parse out the error description to provide good error messages in the UI
                let errorString: String
                do {
                    //TODO actually use the dictionary here?
                    let errorDict = try NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments)
                    errorString = errorDict["error"] as! String
                } catch {
                    errorString = NSString(data: newData, encoding: NSUTF8StringEncoding) as! String
                }
                sendError(errorString)
                return
            }
            
            //Parse the data and use the data (happens in completion handler) */
            self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForPOST)
        }
        
        //Start the request
        task.resume()
        
        return task
        
    }
    
    // given raw JSON, return a usable Foundation object
    private func convertDataWithCompletionHandler(data: NSData, completionHandlerForConvertData: (result: AnyObject!, error: NSError?) -> Void) {
        
        var parsedResult: AnyObject!
        do {
            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            completionHandlerForConvertData(result: parsedResult, error: nil)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(result: nil, error: NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
    }
    
    //MARK: Shared Instance
    class func sharedInstance() -> NetworkRequestBuilder {
        struct Singleton {
            static var sharedInstance = NetworkRequestBuilder()
        }
        return Singleton.sharedInstance
    }
    
}