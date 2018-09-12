//
//  blueViewController.swift
//  Colors
//
//  Created by Diamonique Danner on 7/11/18.
//  Copyright © 2018 Danner Opp., LLC. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase




class blueViewController: UIViewController {
    @IBOutlet var usernameField: UITextField!
    
    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var emailField: UITextField!
    
    @IBAction func register(_ sender: Any) {
        handleSignUp()
    }
    
    @IBAction func login(_ sender: Any) {
        handleSignIn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleSignIn() {
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                self.dismiss(animated: false, completion: nil)
                self.performSegue(withIdentifier: "toBlue", sender: self)
            } else {
                print(error)
            }
        }
    }
    
    @objc func handleSignUp() {
        guard let username = usernameField.text else { return }
        guard let password = passwordField.text else { return }
        guard let email = emailField.text else { return }
    
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
       if error == nil && user != nil {
                print("User created!")
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = username
        changeRequest?.commitChanges { error in
            if error == nil {
                print("Username Created!")
            }
        }
    
        
            } else {
                print(error)
            }
        }
    
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
