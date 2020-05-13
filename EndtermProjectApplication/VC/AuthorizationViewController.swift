//
//  AuthorizationViewController.swift
//  EndtermProjectApplication
//
//  Created by Бурибеков Даурен on 5/6/20.
//  Copyright © 2020 Бурибеков Даурен. All rights reserved.
//

import UIKit
import FirebaseAuth
class AuthorizationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var imagePhot: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "MyPageVCSegue", sender: self)
        }
        let Tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
        loginButton.layer.cornerRadius = 5
    }
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
           emailField.resignFirstResponder()
           passwordField.becomeFirstResponder()
        } else {
           passwordField.resignFirstResponder()
            self.login(view as Any)
        }
        return false
    }
    override func viewDidAppear(_ animated: Bool) {
        emailField.delegate = self
        passwordField.delegate = self

        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "MyPageVCSegue", sender: self)
        }
    }
    @IBAction func login(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!){
            (result, error) in
            if (error != nil) {
                let alertController = UIAlertController(title: "Ошибка", message:
                    error?.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "ОК", style: .default))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            self.emailField.text = ""
            self.passwordField.text = ""
            self.performSegue(withIdentifier: "MyPageVCSegue", sender: self)
        }
    }
    
    
}
