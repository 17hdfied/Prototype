//
//  SignUpVCViewController.swift
//  Prototype
//
//  Created by Hardik Wason on 22/01/18.
//  Copyright © 2018 Hardik Wason. All rights reserved.
//

import UIKit
import Firebase

class SignUpVCViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    @IBOutlet weak var hide_lbl: UILabel!               //Outlet for Hiding Label in SignUpVCViewController
    @IBOutlet weak var name_field: UITextField!         //Outlet for Full Name Text Field
    @IBOutlet weak var email_field: UITextField!        //Outlet for Email Address Text Field
    @IBOutlet weak var phone_field: UITextField!        //Outlet for Phone Number Text Field
    @IBOutlet weak var password_field: UITextField!     //Outlet for Password Text Field
    @IBOutlet weak var confirm_field: UITextField!      // Outlet for Confirm Password Text Field
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gesture for the Sign In Label present in SignUpVCViewController
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.someAction))
        SignIn_lbl.isUserInteractionEnabled = true
        SignIn_lbl.addGestureRecognizer(tap)
        
        // Gesture for setting Profile Image present in SignUpVCViewController
        let tap_img = UITapGestureRecognizer(target: self, action: #selector(SignUpVCViewController.someAct))
        profile_image.isUserInteractionEnabled = true
        profile_image.addGestureRecognizer(tap_img)
        
        
        // Styling the Profile Image by providing the corner Radius Property
        self.imagepicker.delegate = self
        self.profile_image.layer.cornerRadius = self.profile_image.frame.size.width / 2;
        
        
        // This delegate is used for text fields to hide the keyboard by just hitting the button RETURN present in Keyboard.
        email_field.delegate = self
        password_field.delegate = self
        name_field.delegate = self
        confirm_field.delegate = self
        phone_field.delegate = self
    }
    
        // It is used to Change the color of the Status Bar from dark to bright color.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    // Perform Gesture to move the SignUpVCViewController to viewController
    @IBOutlet weak var SignIn_lbl: UILabel!
    @objc func someAction(sender: UITapGestureRecognizer)
    {
        performSegue(withIdentifier: "Login", sender: self )
    }
    
  
    // Perform Gesture to set the Profile Image of the User who is signing up
    @IBOutlet weak var profile_image: UIImageView!
    var imagepicker = UIImagePickerController()
    @objc func someAct(sender:UITapGestureRecognizer)
    {
        self.imagepicker.allowsEditing = false
        self.imagepicker.sourceType = .savedPhotosAlbum
        self.present(imagepicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.profile_image.contentMode = .scaleAspectFill
            self.profile_image.image = pickedImage
            hide_lbl.isHidden = true
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.imagepicker = UIImagePickerController()
        dismiss(animated: true, completion: nil)
    }
    
    
    //Sign Up Perform Some Actions 
    @IBAction func Signup_btn(_ sender: Any) {
        if name_field.text == "" || password_field.text == "" || name_field.text == "" ||  phone_field.text == "" {
            let alert = UIAlertController(title: "Empty Fields", message: "Fields cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
       else if password_field.text != confirm_field.text
        {
            let alert = UIAlertController(title: "Password do not match", message: "Please Enter the Valid Password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            Auth.auth().createUser(withEmail: email_field.text!, password: password_field.text!, completion: { (user, error) in
                if error != nil
                {
                    print("HD:Unsuccessful Login With Firbase")
                }
                else
                {
                    print("HD: Yo have done it ")
                }
            })
            performSegue(withIdentifier: "Main", sender: nil)
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
       
    
    
    
}
