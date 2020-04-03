//
//  LoginController.swift
//  MapDemo2020
//
//  Created by admin on 03/04/2020.
//  Copyright © 2020 Markus. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var authentication:Authentication?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authentication = Authentication(parentVC: self)
    }
    
    @IBAction func signupBtnPressed(_ sender: UIButton) {
        if let email = emailField.text, let pwd = passwordField.text { // Check if there is enough text
            if email.count > 5 && pwd.count > 5 {
                Authentication.signUp(email: email, pwd: pwd)
            }
        }
    }
    
    @IBAction func signinBtnPressed(_ sender: UIButton) {
        if let email = emailField.text, let pwd = passwordField.text { // Check if there is enough text
            if email.count > 5 && pwd.count > 5 {
                Authentication.signIn(email: email, pwd: pwd)
            }
        }
    }
    
    func presentMapView() {
        performSegue(withIdentifier: "toMapView", sender: self)
    }
    
    func moveToLogin() {
        dismiss(animated: true, completion: nil)
    }

}
