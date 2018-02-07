//
//  ViewController.swift
//  Prototype
//
//  Created by Hardik Wason on 20/01/18.
//  Copyright © 2018 Hardik Wason. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper
class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var email_txt: UITextField! //Email Text Field in ViewController
    @IBOutlet weak var pass_txt: UITextField!  //Password Text Field in ViewController
    @IBOutlet weak var sign_up: UILabel!       //SignUP Label in ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        // Gesture functions are used for the "Sign Up" Label
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.someAction))
        sign_up.isUserInteractionEnabled = true
        sign_up.addGestureRecognizer(tap)
        
        // This delegate is used for text fields to hide the keyboard by just hitting the button RETURN present in Keyboard
        email_txt.delegate = self
        pass_txt.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
     if let keychain = KeychainWrapper.standard.string(forKey: KEY_UID)
     {
        print("yo man \(String(describing: keychain))")
        performSegue(withIdentifier: "gofeed", sender: nil)
        }
    }
    
    // Perform Gesture to move the viewController to SignUpVCViewController
   @objc func someAction(sender:UITapGestureRecognizer)
    {
        performSegue(withIdentifier: "SignUp", sender: self)
    }
    
    // Perform Sign In through Email and Password and store in Firebase
    @IBAction func login_btn(_ sender: Any) {
        if email_txt.text == "" || pass_txt.text == ""
        {
            let alert = UIAlertController(title: "Empty Fields", message: "Fields cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            Auth.auth().signIn(withEmail: email_txt.text!, password: pass_txt.text!, completion: { (user, error) in
                if error == nil
                {
                    print("HD: Authenticated with Firebase dude")
                    if let user = user
                    {
                        self.completeSignIn(id: user.uid)
                    }
                } else
                {
                    let alert = UIAlertController(title: "Invalid Email/Password", message: "Please Enter Valid Details", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
            
        }
        
    }
    
    // Perform Sign In through Facebook and then store the users in Firebase
    @IBAction func fb_btn(_ sender: Any) {
        let fblogin = FBSDKLoginManager()
        fblogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil
            {
                print("HD: Unsuccessful Login in FB")
            } else if result?.isCancelled == true
            {
                print("HD: User cancelled Login in FB")
            } else {
                print("HD: Successful Login in FB")
                let credential = FacebookAuthProvider.credential(withAccessToken:FBSDKAccessToken.current().tokenString)
                self.firebase_auth(credential)
            }
        }
    }
    func firebase_auth(_ credential: AuthCredential)
    {
        Auth.auth().signIn(with: credential) { (user,error) in
            if error != nil
            {
                print("HD: Unsuccessful Login in Firebase")
            } else
            {
                print("HD: Successful Login in Firebase")
                if let user = user {
                    self.completeSignIn(id: user.uid)
                }
            }
        }
    }
    
    func completeSignIn(id: String)
    {
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        performSegue(withIdentifier: "gofeed", sender: nil)
    }
    
    
    
    
    // It is use to hide the keyboard by just tapping anywhere on the screen.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

