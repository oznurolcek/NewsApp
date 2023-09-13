//
//  LoginPage.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 8.09.2023.
//

import UIKit

final class LoginPage: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var loginSegmentView: UIView!
    @IBOutlet weak var signUpSegmentView: UIView!
    
    var isLogin: Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        preparePage()
    }
    
    private func preparePage() {
        if isLogin == true {
            segmentControl.selectedSegmentIndex = 0
            self.view.bringSubviewToFront(loginSegmentView)
        } else {
            segmentControl.selectedSegmentIndex = 1
            self.view.bringSubviewToFront(signUpSegmentView)
        }
        
        loginSegmentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        signUpSegmentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    
    @IBAction func segmentAct(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.view.bringSubviewToFront(loginSegmentView)
        case 1:
            self.view.bringSubviewToFront(signUpSegmentView)
        default:
            break
        }
    }
    
    

}
