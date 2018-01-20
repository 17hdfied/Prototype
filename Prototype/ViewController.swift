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
class ViewController: UIViewController {

    @IBOutlet weak var email_txt: UITextField!
    @IBOutlet weak var pass_txt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func login_btn(_ sender: Any) {
        if let email = email_txt.text, let pass = pass_txt.text {
            Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, error) in
                if error == nil
                {
                    print("HD: Already Authenticated with Firebase")
                } else
                {
                    Auth.auth().createUser(withEmail: email, password: pass, completion: { (user, error) in
                        if error != nil {
                            print("HD: Unsuccessful Login of Email")
                        }  else {
                            print("HD: Successful Login of Email")
                        }
                    })
                }
            })
        }
    }
    
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
            }
        }
    }
    

}

