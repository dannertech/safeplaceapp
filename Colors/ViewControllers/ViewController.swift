//
//  ViewController.swift
//  Colors
//
//  Created by Diamonique Danner on 6/14/18.
//  Copyright © 2018 Danner Opp., LLC. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation





class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
  
    let latitude : Double = 0
    let longitude : Double = 0
    
    @IBOutlet var resourcesLabel: UILabel!
    
    
    let customFont = UIFont(name: "SF Compact Text", size: 22)
    
    
    @IBOutlet var shelterView: UIView!
    
    @IBOutlet var pantryTableView: UITableView!
    
    
    @IBOutlet var foodTableView: UITableView!
    
    var count = 0
    @IBOutlet var tableView: UITableView!
    
  
    var locationManager = CLLocationManager()
    
    @IBOutlet var pantryView: pantryView!
    
    @IBOutlet var foodView: foodView!
    
    @IBOutlet var foodMapView: MKMapView!
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var pantryMapView: MKMapView!
    
   
    
    @IBAction func customSegmentValueChanged(_ sender: CustomSegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
           pantryView.isHidden = true
            foodView.isHidden = true
            count = 0
      pantryTableView.isHidden = true
            foodTableView.isHidden = true
            tableView.isHidden = false
        case 1:
            pantryView.isHidden = false
            foodView.isHidden = true
          tableView.isHidden = true
            foodTableView.isHidden = false
            pantryTableView.isHidden = true
     count = 1
            
        case 2:
            foodView.isHidden = false
            pantryView.isHidden = true
            count = 2
            tableView.isHidden = true
            foodTableView.isHidden = true
            pantryTableView.isHidden = false
        default:
            break
        }
        
    }
    let pantryPoints = [["title": "Youth Reach Out", "latitude": 33.7303826, "longitude": -84.4778337, "phoneNumber": "(404)753-5253"],["title": "Malachi's Storehouse", "latitude": 33.9340801, "longitude": -84.3641085, "phoneNumber": "(678)687-5357"],["title": "Lee-Stelzer Heritage Museum", "latitude": 33.7640275, "longitude": -84.3849327, "phoneNumber" : "(404)373-6327"],["title": "Hosea Helps", "latitude": 33.7690423, "longitude": -84.5267832, "phoneNumber" : "(404)755-3353"],["title": "People United For Change", "latitude": 33.7059313, "longitude": -84.4927487, "phoneNumber" : "(404)550-6944"],["title": "Essence of Hope Food Pantry", "latitude": 33.699878, "longitude": -84.411241, "phoneNumber" : "(404)418-8920"],["title": "Community Market Place", "latitude": 33.731578, "longitude": -84.5084662, "phoneNumber" : "(404)755-4100"]]
    
  
    
    let shelterPoints = [["title": "Lost-N-Found", "latitude": 33.8192626, "longitude": -84.4161292, "phoneNumber" : "(678)856-7824"], ["title": "Youth Connections", "latitude": 33.6294598, "longitude": -84.578269, "phoneNumber" : "(404)599-9297"],["title": "Open Hearts Youth Shelter", "latitude": 33.7370523, "longitude": -84.3816679, "phoneNumber" : "(770)912-2972"]]
    
    
    let foodPoints = [["title": "Safehouse Outreach", "latitude": 33.7579642, "longitude": -84.4549051, "phoneNumber": "(404)523-2221"], ["title": "Trinity Table", "latitude": 33.747829, "longitude": -84.3928907, "phoneNumber": "(404)659-6236"],["title": "Clyde's Kitchen", "latitude": 33.7654362, "longitude": -84.436969, "phoneNumber": "(404)873-7650"]]
    
    
   
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resourcesLabel.font = customFont
        
        
        
        pantryView.isHidden = true
        pantryTableView.isHidden = true
        
        foodView.isHidden = true
        foodTableView.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
        tableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
 
        
        mapView.delegate = self
        
        
        for shelterPoint in shelterPoints {
            let annotation = MKPointAnnotation()
            annotation.title = shelterPoint["title"] as? String
            annotation.coordinate = CLLocationCoordinate2D(latitude: shelterPoint["latitude"] as! Double, longitude: shelterPoint["longitude"] as! Double)
            mapView.addAnnotation(annotation)
    
            
        }
        
        for pantryPoint in pantryPoints {
            let annotation = MKPointAnnotation()
            annotation.title = pantryPoint["title"] as? String
            annotation.coordinate = CLLocationCoordinate2D(latitude: pantryPoint["latitude"] as! Double, longitude: pantryPoint["longitude"] as! Double)
            pantryMapView.addAnnotation(annotation)
            
            
        }
        
        for foodPoint in foodPoints {
            let annotation = MKPointAnnotation()
            annotation.title = foodPoint["title"] as? String
            annotation.coordinate = CLLocationCoordinate2D(latitude: foodPoint["latitude"] as! Double, longitude: foodPoint["longitude"] as! Double)
            foodMapView.addAnnotation(annotation)
        }
        
        
       
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count : Int?
        if tableView == self.tableView {
        count = 3
        } else if tableView == self.pantryTableView {
            count = 7
        } else if tableView == self.foodTableView {
            count = 3
        }
        return count!
    }
    
    var selectedIndexPath : IndexPath? = nil
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAtIndexPath was called")
        var cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        
        switch selectedIndexPath {
        case nil:
            selectedIndexPath = indexPath
        default:
            if selectedIndexPath! == indexPath {
                selectedIndexPath = nil
            } else {
                    selectedIndexPath = indexPath
                }
            }
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let smallHeight : CGFloat = 60.0
        let expandedHeight : CGFloat = 180.0
        let ip = indexPath
        if selectedIndexPath != nil {
            if ip == selectedIndexPath! {
      return expandedHeight
            } else {
                return smallHeight
            }
        } else {
            return smallHeight
            
        }
    }
    

    
   // func numberOfSections(in tableView: UITableView) -> Int {
  //      return 1
 //   }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        if tableView == self.tableView {
         let point = shelterPoints[indexPath.row]
        cell.nameLabel.text = point["title"] as? String
        cell.phoneNumberLabel.text = point["phoneNumber"] as? String
        cell.contentView.backgroundColor = UIColor.white
        } else if tableView == self.foodTableView {
            let point = foodPoints[indexPath.row]
            cell.nameLabel.text = point["title"] as? String
            cell.phoneNumberLabel.text = point["phoneNumber"] as? String
            cell.contentView.backgroundColor = UIColor.white
        } else if tableView == self.pantryTableView {
            let point = pantryPoints[indexPath.row]
            cell.nameLabel.text = point["title"] as? String
            cell.phoneNumberLabel.text = point["phoneNumber"] as? String
            cell.contentView.backgroundColor = UIColor.white
        }
        return cell
    }
    
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
        let userLocation : CLLocation = locations[0]
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        
        let latDelta : CLLocationDegrees = 0.05
        let lonDelta : CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        self.mapView.setRegion(region, animated: true)
        self.foodMapView.setRegion(region, animated: true)
        self.pantryMapView.setRegion(region, animated: true)
        
        
        let userLocationAnnotationPin = MKPointAnnotation()
        mapView.removeAnnotation(userLocationAnnotationPin)
       let userLocationAnnotation = locations.last! as CLLocation
      
        userLocationAnnotationPin.title = "My Location"
        userLocationAnnotationPin.coordinate = userLocationAnnotation.coordinate
        mapView.addAnnotation(userLocationAnnotationPin)
        
        
        UserDefaults.standard.set(latitude, forKey: "latitude")
        UserDefaults.standard.set(longitude, forKey: "longitude")
    }
    
    
        
}


