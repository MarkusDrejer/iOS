//
//  ViewController.swift
//  Sensors
//
//  Created by admin on 26/04/2020.
//  Copyright © 2020 Markus. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func touchIDPressed(_ sender: UIButton) {
        touchIDAuth()
    }
    
    func touchIDAuth() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self.performSegue(withIdentifier: "detailSegue", sender: self)
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Not Avaliable", message: "Your device is not configured for this type of authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
        }
    }
}

