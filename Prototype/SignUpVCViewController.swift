//
//  SignUpVCViewController.swift
//  Prototype
//
//  Created by Hardik Wason on 22/01/18.
//  Copyright © 2018 Hardik Wason. All rights reserved.
//

import UIKit

class SignUpVCViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var hide_lbl: UILabel! // Hide Label in SignUpVCViewController
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

    
        
        
       
    
    
    
}
