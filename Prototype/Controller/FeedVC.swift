//
//  FeedVC.swift
//  Prototype
//
//  Created by Hardik Wason on 05/02/18.
//  Copyright © 2018 Hardik Wason. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signout(_ sender: Any) {
     KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goback", sender: nil)
    }
    
    
   

}
