//
//  uberViewController.swift
//  Colors
//
//  Created by Diamonique Danner on 8/8/18.
//  Copyright © 2018 Danner Opp., LLC. All rights reserved.
//

import UIKit
import UberRides
import CoreLocation

class uberViewController: UIViewController, CLLocationManagerDelegate {
var locationManager = CLLocationManager()
    var locationFound = false
    

    
    let longitude = UserDefaults.standard.value(forKey: "longitude")
    
   
    let latitude = UserDefaults.standard.value(forKey: "latitude")
    
    
    
    
 
    
    //credit to Vishwas Singh via StackOverflow
    @IBAction func openGoogleMap(_ sender: Any) {
        if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
            let userLatitude = UserDefaults.standard.value(forKey: "userLatitude")
            let userLongitude = UserDefaults.standard.value(forKey: "userLongitude")
            
            let directionsURL = "http://maps.google.com/?saddr=35.6813023,139.7640529&daddr=35.4657901,139.6201192"
            
           
            UIApplication.shared.openURL(URL(string: directionsURL)!)
            
            
        } else {
            let directionsURL = "https://maps.apple.com/?saddr=35.6813023,139.7640529&daddr=35.4657901,139.6201192"
            UIApplication.shared.openURL(URL(string: directionsURL)!)
        }
    }
  
    
    @IBAction func openAppleMap(_ sender: Any) {
        
        
        let userLatitude = UserDefaults.standard.value(forKey: "userLatitude") as? String
        let userLongitude = UserDefaults.standard.value(forKey: "userLongitude") as? String
        
  
        
        
       let directionsURL = "https://maps.apple.com/?saddr=\(userLatitude!),\(userLongitude!)&daddr=\(latitude as? String),\(longitude as? String)"
        
        print(userLatitude!)
        print(userLongitude!)
        print(latitude!)
        print(longitude!)
     

      guard let url = URL(string: directionsURL) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        
        }
        
    }
        
    let builder = RideParametersBuilder()
    let pickupLocation = CLLocation(latitude: (UserDefaults.standard.value(forKey: "latitude") as? Double)!, longitude: (UserDefaults.standard.value(forKey: "longitude") as? Double)!)
    
    @IBOutlet var uberRideView: UIView!
    let button = RideRequestButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(latitude)
        print(longitude)
  
        
//uberRideView.addSubview(button)
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let builder = RideParametersBuilder()
        let pickupLocation = CLLocation(latitude: (UserDefaults.standard.value(forKey: "latitude") as? Double)!, longitude: (UserDefaults.standard.value(forKey: "longitude") as? Double)!)
     //   let dropoffLocation = CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        builder.pickupLocation = pickupLocation
      //  builder.dropoffLocation = dropoffLocation
        
   
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locationFound == false {
            
        
        let userLocation : CLLocation = locations[0]
        
        print(userLocation)
        print(userLocation.coordinate.latitude)
        
        UserDefaults.standard.set(userLocation.coordinate.latitude, forKey: "userLatitude")
        UserDefaults.standard.set(userLocation.coordinate.longitude, forKey: "userLongitude")
        
        UserDefaults().synchronize()
        }
        locationFound = true
    }
    
    
    
   
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
