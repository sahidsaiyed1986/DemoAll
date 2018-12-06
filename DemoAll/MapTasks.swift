//
//  MapTasks.swift
//  DemoAll
//
//  Created by apple on 11/28/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class MapTasks: NSObject {
 
    let baseUrl = "https://maps.googleapis.com/maps/api/geocode/json?"
    var lookAddressResults:[String:Any] = [:]
    var fetchedFormattedAddress: String!
    var fetchedAddressLongitude: Double!
    var fetchedAddressLatitude: Double!
    
//    override init() {
//        super.init()
//    }
   // https://maps.googleapis.com/maps/api/geocode/xml?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=YOUR_API_KEY

    func doSomthing(name:String,andWithHandler handler:((stau:String,dp:Bool)) -> Void)   {

    }
    
    func geocodeAddress(address: String!, withCompletionHandler completionHandler: @escaping (((status:String, sucsee:Bool)) ->Void)) {
        if let lookupAddress = address {
            
//            self.doSomthing(name: "sam", andWithHandler: {(stau,dp) ->Void in
//
//
//            })
            self.doSomthing(name: "test"){(stau,dp) in
                
            }
            var geocodeURLString = baseUrl + "address=" + lookupAddress + "&key=AIzaSyCNKMvOAdA5jueNbSLLrkv5GvzD6CCTV8c"
            geocodeURLString = geocodeURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
           // url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)! 
            let geocodeURL = URL(string: geocodeURLString)

            DispatchQueue.main.async(execute: { () -> Void in
                let geocodingResultsData:Data = (NSData(contentsOf: geocodeURL!) as Data?)!
                print(geocodingResultsData as Any)
               // var error:NSError
               
                guard let dictionary = try? JSONSerialization.jsonObject(with: geocodingResultsData, options: .mutableContainers) as? [String : Any] else {
                    completionHandler((status:"",sucsee: false))
                    return
                }
                let status = dictionary?["status"] as! String


                guard status == "OK" else{
                    completionHandler((status:"",sucsee: false))
                    return
                }
                let allresults:NSArray = dictionary! ["results"] as! NSArray
                self.lookAddressResults = allresults[0] as! [String : Any]
                self.fetchedFormattedAddress = (self.lookAddressResults["formatted_address"] as! String)
                let geometry:[NSString:Any]  = self.lookAddressResults["geometry"]  as! [NSString : Any]
                let location:[NSString:Any] = geometry["location"] as! [NSString:Any]
                self.fetchedAddressLongitude = location["lng"] as? Double
                self.fetchedAddressLatitude = location["lat"] as? Double
                completionHandler((status:status,sucsee: true))
                
                
                
            })
 
        }
        else{
            completionHandler((status:"No valid address.",sucsee: false))
        }
    }
    
}
