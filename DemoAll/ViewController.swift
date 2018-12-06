//
//  ViewController.swift
//  DemoAll
//
//  Created by apple on 11/26/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var viewMap: GMSMapView!
    var locationManager = CLLocationManager()
    var findMyLocation = false
    var mapTasks = MapTasks()
    var locationMarker: GMSMarker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
       //viewMap.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.New, context: nil)
        viewMap.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.new, context: nil)  
    }

  
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            viewMap.isMyLocationEnabled = true
        }
    }
    func myLocation() {
        let address = "NH School,Naya Nagar Mira Road"
        self.mapTasks.geocodeAddress(address: address, withCompletionHandler: { (status,sucsee) -> Void in
            print(status)
            guard status == "OK"  else{
                return
            }
         
            
            let cordinate = CLLocationCoordinate2D(latitude: self.mapTasks.fetchedAddressLatitude, longitude: self.mapTasks.fetchedAddressLongitude)
            self.viewMap.camera = GMSCameraPosition.camera(withTarget: cordinate, zoom: 14.0)
            self.setUpLocation(coordinate: cordinate)
            
        })
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if !findMyLocation {
            let myLocation: CLLocation = change?[NSKeyValueChangeKey.newKey] as! CLLocation
            viewMap.camera = GMSCameraPosition.camera(withTarget: myLocation.coordinate, zoom: 10.0)
            viewMap.settings.myLocationButton = true
            findMyLocation = true
        }
    }

//    func setupLocationMarker(coordinate: CLLocationCoordinate2D) {
//        if locationMarker != nil {
//            locationMarker.map = nil
//        }
//
//        locationMarker = GMSMarker(position: coordinate)
//        locationMarker.map = viewMap
//
//        locationMarker.title = mapTasks.fetchedFormattedAddress
//        locationMarker.appearAnimation = GMSMarkerAnimation
//        locationMarker.icon = GMSMarker.markerImageWithColor(UIColor.blueColor)
//        locationMarker.opacity = 0.75
//
//        locationMarker.flat = true
//        locationMarker.snippet = "The best place on earth."
//    }
//
    func setUpLocation(coordinate:CLLocationCoordinate2D)  {
        if locationMarker != nil {
            locationMarker.map = nil
        }
        locationMarker = GMSMarker(position: coordinate)
        locationMarker.map = viewMap
        locationMarker.title = mapTasks.fetchedFormattedAddress
        locationMarker.appearAnimation = GMSMarkerAnimation.pop
        locationMarker.icon = GMSMarker.markerImage(with: UIColor.blue)
        locationMarker.opacity = 0.75
        locationMarker.isFlat = true
        locationMarker.snippet = "Home"
    }
}




