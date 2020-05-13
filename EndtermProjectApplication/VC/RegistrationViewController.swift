//
//  RegistrationViewController.swift
//  EndtermProjectApplication
//
//  Created by Бурибеков Даурен on 5/8/20.
//  Copyright © 2020 Бурибеков Даурен. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var registrationButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let Tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
        registrationButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            emailField.resignFirstResponder()
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            passwordField.resignFirstResponder()
            confirmPasswordField.becomeFirstResponder()
        } else {
            confirmPasswordField.resignFirstResponder()
            self.registration(view as Any)
        }
        return false
    }
    override func viewDidAppear(_ animated: Bool) {
        emailField.delegate = self
        passwordField.delegate = self
        confirmPasswordField.delegate = self
    }
    @IBAction func registration(_ sender: Any) {
        if passwordField.text == confirmPasswordField.text {
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) {
                (result, error) in
                if (error != nil), self.confirmPasswordField.text == ""{
                    let alertController = UIAlertController(title: "Ошибка", message:
                        error?.localizedDescription, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "ОК", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                self.emailField.text = ""
                self.passwordField.text = ""
                let alertController = UIAlertController(title: "Подтверждение", message:
                    "Пользователь добавлен!", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                    self.navigationController?.popViewController(animated: true)
                })
                self.present(alertController, animated: true, completion: nil)
            }
        } else {
            let alertController = UIAlertController(title: "Ошибка", message:
                "Пароли должны совпадать!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "ОК", style: .default))
            self.present(alertController, animated: true, completion: nil)
            return
        }
    }
}
