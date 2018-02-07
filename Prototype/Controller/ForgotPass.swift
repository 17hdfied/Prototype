//
//  ForgotPass.swift
//  Prototype
//
//  Created by Hardik Wason on 05/02/18.
//  Copyright © 2018 Hardik Wason. All rights reserved.
//

import UIKit
import Firebase

class ForgotPass: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var email_text: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        email_text.delegate = self
    }
    
    // This will perform the function of Resetting your Password
    @IBAction func Reset_btn(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: email_text.text!) { (error) in
            if error == nil {
                print("Congo you are good man with these stuff")
                let alert = UIAlertController(title: "Reset Password", message: "Reset Password is sent to you", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                let alert = UIAlertController(title: "Reset Password", message: "Invalid Email Address", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    
       // It is use to hide the keyboard by just tapping anywhere on the screen.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    // It is used to Change the color of the Status Bar from dark to bright color.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
