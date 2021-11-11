//
//  ViewController.swift
//  FavoritePlaces
//
//  Created by ysf on 10.11.21.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var userNameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parseObject = PFObject(className: "")
    }

    @IBAction func signInClicked(_ sender: Any) {
        
        if userNameText.text != "" && passwordText.text != "" {
            PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { user, error in
                if error != nil {
                    self.makeAlert(title: "ERROR!", message: error?.localizedDescription ?? "ERROR!!")
                }
                //Segue
                self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
            }
            
        } else {
            makeAlert(title: "ERROR!", message: "Password / Username ??")
        }
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if userNameText.text != "" && passwordText.text != "" {
        
           let user = PFUser()
            user.username = userNameText.text!
            user.password = passwordText.text!
            
            user.signUpInBackground { success, error in
                if error != nil {
                    self.makeAlert(title: "ERROR!", message: error?.localizedDescription ?? "Error!!")
                }else {
                    print("success")
                }
            }
            
            
        } else {
            makeAlert(title: "ERROR!", message: "Username / Password ??")
        }
}
    
    func makeAlert(title:String,message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
