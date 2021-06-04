//
//  VC1.swift
//  ImageToFireBase
//
//  Created by abdullah FH  on 21/10/1442 AH.
//

import UIKit
import Firebase

class VC1: UIViewController {
    
    

    @IBOutlet weak var LogUI: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        LogUI.layer.cornerRadius = 12
    }
    
    
    @IBAction func LogAnoAct(_ sender: Any) {
        Auth.auth().signInAnonymously { (user, error) in
            if error == nil{
                print("Login Success")
                self.performSegue(withIdentifier: "GotomyView", sender: nil)
                print(user as Any)
            }else{
                print("Login Error!!!")
            }
        }
    }
    
    
    
    
    
    
    

}
