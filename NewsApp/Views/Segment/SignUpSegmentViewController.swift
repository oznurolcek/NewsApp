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
            let alert = UIAlertController(title: "Missing Field Data", message: "Please fill in all fields!", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Okay", style: .default)
                        alert.addAction(okAction)
                        self.present(alert, animated: true)
            return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { (result, error) in
            if let e = error {
                print(e)
            } else {
                let alert = UIAlertController(title: "Üye Olundu!", message: "Login sayfasına geçiniz.", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "Okay", style: .default)
                            alert.addAction(okAction)
                            self.present(alert, animated: true)
            }
            
        })
        
    }
    
}
