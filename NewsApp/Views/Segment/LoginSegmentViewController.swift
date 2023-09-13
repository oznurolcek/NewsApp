//
//  LoginSegmentViewController.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 10.09.2023.
//

import UIKit
import FirebaseAuth

class LoginSegmentViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.cornerRadius = 16
    }
    
    @IBAction func loginButtonAct(_ sender: Any) {
        let storyboard = UIStoryboard(name: "NewsPage", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "CustomTabBarController") as? CustomTabBarController{
            guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
                alertDialog(title: "Missing Field Data", message: "Please fill in all fields!")
                return
            }
            
            Auth.auth().signIn(withEmail: email, password: password, completion: { (result, error) in
                if error != nil {
                    self.alertDialog(title: "Error", message: "Email or password is incorrect")
                } else {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            })
            
        }
        
    }
    
    func alertDialog(title : String, message : String) {
        let alertMessage = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in
        }
        alertMessage.addAction(okButton)
        self.present(alertMessage, animated: true)
    }
}


