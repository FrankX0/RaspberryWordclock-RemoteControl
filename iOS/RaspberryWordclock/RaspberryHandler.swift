//
//  RaspberryHandler.swift
//  RaspberryWordclock
//
//  Created by Pascal Henze on 05.01.16.
//  Copyright (c) 2016 Pascal Henze. All rights reserved.
//

import Foundation

class RaspberryHandler {
    static let sharedInstance = RaspberryHandler()
    
    private init() {
        // /GPIO/(gpioNumber)/value
    
    }
    
    func webIOUser() -> String {
        if let value: AnyObject = NSUserDefaults.standardUserDefaults().valueForKey(kWebIOUserUserDefaultsKey) {
            return value as! String
        }else {
            return ""
        }
    }
    
    func webIOPassword() -> String {
        if let value: AnyObject = NSUserDefaults.standardUserDefaults().valueForKey(kWebIOPasswordUserDefaultsKey) {
            return value as! String
        }else {
            return ""
        }
    }
    
    func raspberryIP() -> String {
        if let value: AnyObject = NSUserDefaults.standardUserDefaults().valueForKey(kRasperryIPUserDefaultsKey) {
            let stringValue = value as! String
            return stringValue
        }else {
            return ""
        }
    }
    
    func raspberryURL() -> String {
        if let value: AnyObject = NSUserDefaults.standardUserDefaults().valueForKey(kRasperryIPUserDefaultsKey) {
            let stringValue = value as! String
            return "http://" + stringValue
        }else {
            return ""
        }
    }
    
    func wordclockButtons() -> String {
        if let value: AnyObject = NSUserDefaults.standardUserDefaults().valueForKey(kButtonsUserDefaultsKey) {
            return value as! String
        }else {
            return ""
        }
    }
    func rightButtonNumber() -> String {
        let array = self.wordclockButtons().componentsSeparatedByString(";")
        return array[2]
    }
    
    func leftButtonNumber() -> String {
        let array = self.wordclockButtons().componentsSeparatedByString(";")
        return array[0]
    }
    
    func returnButtonNumber() -> String {
        let array = self.wordclockButtons().componentsSeparatedByString(";")
        return array[1]
    }
    
    func toggleGPIO(number : String,callback: () -> Void,errorCallback: () -> Void) -> Void {
        
        let firstURL = "/GPIO/" + number + "/value/0"
        let secondURL = "/GPIO/" + number + "/value/1"
        
        RaspberryHandler.sharedInstance.post(firstURL, data: "", callback: { (result) -> Void in
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                RaspberryHandler.sharedInstance.post(secondURL, data: "", callback: { (result) -> Void in
                    callback()
                    }) { () -> Void in
                        errorCallback()
                }
            }
            
            }) { () -> Void in
               errorCallback()
        }
        
    }
    
    func post(url : String , data : String,callback: (String) -> Void,errorCallback: () -> Void){
        //POST /GPIO/0/pulse/
        
        let username = self.webIOUser()
        let password = self.webIOPassword()
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        
        let baseUrl = self.raspberryURL().stringByAppendingString(url)
        let request = NSMutableURLRequest(URL: NSURL(string: baseUrl)!)
        request.HTTPMethod = "POST"
        request.HTTPBody = data.dataUsingEncoding(NSUTF8StringEncoding)
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 2
        //let postString = "id=13&name=Jack"
        // request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                    errorCallback()
                }
                
                if let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding) {
                    callback(responseString as! String)
                    print("responseString = \(responseString)")
                }else {
                    errorCallback()
                }
            }else {
                errorCallback()
            }
            
            
            
        })
        task.resume()
    }
    
    
    func get(url : String,callback: (String) -> Void,errorCallback: () -> Void) {
        // set up the base64-encoded credentials
        let username = self.webIOUser()
        let password = self.webIOPassword()
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)

        let baseUrl = self.raspberryURL().stringByAppendingString(url)
        let request = NSMutableURLRequest(URL: NSURL(string: baseUrl)!)
        request.HTTPMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 10
        //let postString = "id=13&name=Jack"
       // request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                    errorCallback()
                }
                
                if let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding) {
                    callback(responseString as! String)
                    print("responseString = \(responseString)")
                }else {
                    errorCallback()
                }
            }else {
                errorCallback()
            }
            
            
            
        })
    
        task.resume()
    }
}