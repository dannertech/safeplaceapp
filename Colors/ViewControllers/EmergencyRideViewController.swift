//
//  EmergencyRideViewController.swift
//  Colors
//
//  Created by Diamonique Danner on 6/29/18.
//  Copyright © 2018 Danner Opp., LLC. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseDatabase
import CoreLocation


class EmergencyRideViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let locations = ["Lost-N-Found Youth Shelter"]
    let numbers = [0,1,2,3,4,5]

    
    @IBOutlet var locationNameLabel: UITextField!
    
    @IBOutlet var clothingDescription: UITextField!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationTableViewCell
        cell.cellTag = indexPath.row

        cell.locationLabel.text = locations[indexPath.row]
        
       return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //credit to andrewCanProgram via StackOverflow
        for cell in tableView.visibleCells as! [LocationTableViewCell] {
            if cell.cellTag == indexPath.row {
                if cell.accessoryType == UITableViewCellAccessoryType.none {
                    cell.accessoryType = UITableViewCellAccessoryType.checkmark
                    UserDefaults.standard.set(cell.locationLabel.text, forKey: "dropoffLocation")
                    }
                }
            if cell.cellTag != indexPath.row {
                cell.accessoryType = UITableViewCellAccessoryType.none
                
              
            }
        }
        
    }
    
    
    
    @IBOutlet var tableView: UITableView!
    


    
    
    var ref = Database.database().reference(withPath: "users")
    
    
    
    @IBAction func sendSOS(_ sender: Any) {
        
        let alert = UIAlertController(title: "Send SOS", message: nil, preferredStyle: .alert)
        let accept = UIAlertAction(title: "Yes", style: .default, handler: { action in
            let description = self.clothingDescription.text
            let location = self.locationNameLabel.text
            let locationName : String = "Atlanta"
            let dropoffLocation = UserDefaults.standard.value(forKey: "dropoffLocation")
            let longitude = UserDefaults.standard.value(forKey: "longitude")
            let latitude = UserDefaults.standard.value(forKey: "latitude")
            let sosItem = SosItem(key: locationName, longitude: longitude as! Double, latitude: latitude as! Double, clothingDescription: description! , placeName: location!, dropoffLocation: dropoffLocation as! String)
            let sosItemRef = self.ref.child(locationName.lowercased())
            sosItemRef.setValue(sosItem.toAnyObject())
            })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            action in
            alert.dismiss(animated: true, completion: nil)
        })
        
    
        alert.addAction(accept)
        alert.addAction(cancel)
        self.present(alert, animated: true)
        
    }
  
    
    
    
   
   

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
