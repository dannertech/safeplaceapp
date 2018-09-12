//
//  blueSide.swift
//  Colors
//
//  Created by Diamonique Danner on 7/31/18.
//  Copyright © 2018 Danner Opp., LLC. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import UberCore


class blueSide: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var ref = Database.database().reference(withPath: "users")
    //add LoginButtonDelegate to class
 
    
  /*  func loginButton(_ button: LoginButton, didLogoutWithSuccess success: Bool) {
        
    }
    
    func loginButton(_ button: LoginButton, didCompleteLoginWithToken accessToken: AccessToken?, error: NSError?) {
        //put code here
    }
 
 */
  
    
    var items : [SosItem] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


       
        self.tableView.dataSource = self
       self.tableView.delegate = self
        self.tableView.allowsSelection = true
        self.tableView.isUserInteractionEnabled = true
        self.tableView.isEditing = false
        
        
     
        
       
        

        // Do any additional setup after loading the view.
       
        ref.observe(.value, with: {
            snapshot in
            var newItems : [SosItem] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let sosItem = SosItem(snapshot: snapshot) {
                    newItems.append(sosItem)
                }
            }
            self.items = newItems
            print(self.items)
            self.tableView.reloadData()
        })
        
 /*        let scopes : [UberScope] = [.profile, .places, .request]
        let loginManager = LoginManager(loginType: .native)
        let loginButton = LoginButton(frame: CGRect.zero, scopes: scopes, loginManager: loginManager)
        loginButton.presentingViewController = self
       loginButton.delegate = self
        view.addSubview(loginButton)
       
        
        */
    }
    

    

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
   
    

    //credit to RayWenderlich.com
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let removedItem = items.remove(at: indexPath.row)
            
            let itemsRef = ref.child(removedItem.key.lowercased())
            itemsRef.removeValue()
            tableView.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return items.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
 
   
    
    
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    
        
    
        
    
    
        //segue to other ViewConroller
        //send users location to other ViewController
        
        /*let alert = UIAlertController(title: "Accept SOS", message: "Would you like to accept this SOS?", preferredStyle: .alert)
        
        
        let accept = UIAlertAction(title: "Accept", style: .default, handler: {
         action in )} */
            
            let sosItem = items[indexPath.row]
        print(sosItem)
            UserDefaults.standard.set(sosItem.clothingDescription, forKey: "clothingDescription")
            UserDefaults.standard.set(sosItem.placeName, forKey: "placeName")
            UserDefaults.standard.set(sosItem.longitude, forKey: "longitude")
            print("Longitude saved!")
            UserDefaults.standard.set(sosItem.latitude, forKey: "latitude")
            print("Latitude saved!")
        print(UserDefaults.standard.value(forKey: "latitude"))
           // tableView.deleteRows(at: [indexPath], with: .fade)
          //  tableView.reloadData()
            self.performSegue(withIdentifier: "uberSegue", sender: self)
    }
        
    /*    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            action in
            alert.dismiss(animated: true, completion: nil)
        })
  
        
        alert.addAction(cancel)
        alert.addAction(accept)
        alert.show(self, sender: self) */
        
        
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! CustomTableViewCell
        
        //get cell data from Firebase
        let sosItem = items[indexPath.row]
cell.descriptionLabel.text = sosItem.clothingDescription
        cell.latitudeLabel.text = String(sosItem.latitude)
        cell.longitudeLabel.text = String(sosItem.longitude)
        cell.locationNameLabel.text = sosItem.placeName
        cell.destinationLabel.text = sosItem.dropoffLocation
     
    
        return cell
    }
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func logout(_ sender: Any) {
        
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
        
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
