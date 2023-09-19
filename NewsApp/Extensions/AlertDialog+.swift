//
//  AlertDialog.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 19.09.2023.
//

import UIKit

extension UIViewController {
    func alertDialog(title : String, message : String) {
        let alertMessage = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in
        }
        alertMessage.addAction(okButton)
        self.present(alertMessage, animated: true)
    }
}
