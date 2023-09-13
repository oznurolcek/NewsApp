//
//  SignUpSegmentViewController.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 10.09.2023.
//

import UIKit
import FirebaseAuth

class SignUpSegmentViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpButton.layer.cornerRadius = 16
    }
    
    @IBAction func signUpButtonAct(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty, let name = nameTextField.text, !name.isEmpty else {
            alertDialog(title: "Missing Field Data", message: "Please fill in all fields!")
            return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { (result, error) in
            if let e = error {
                print(e)
            } else {
                self.alertDialog(title: "Successful!", message: "Go to the login page")
            }
            
        })
        
    }
    
    func alertDialog(title : String, message : String) {
        let alertMessage = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in
        }
        alertMessage.addAction(okButton)
        self.present(alertMessage, animated: true)
    }
    
}
