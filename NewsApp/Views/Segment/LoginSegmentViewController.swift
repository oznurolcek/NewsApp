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
                let alert = UIAlertController(title: "Missing Field Data", message: "Please fill in all fields!", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "Okay", style: .default)
                            alert.addAction(okAction)
                            self.present(alert, animated: true)
                return
            }
            
            Auth.auth().signIn(withEmail: email, password: password, completion: { (result, error) in
                if let e = error {
                    let alert = UIAlertController(title: "Yanlış bilgi", message: "dddd!", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "Okay", style: .default)
                                alert.addAction(okAction)
                                self.present(alert, animated: true)
                } else {
                    self.navigationController?.pushViewController(vc, animated: true)
                    print("x")
                }
                
            })
            
        }
        
    }
    


}
