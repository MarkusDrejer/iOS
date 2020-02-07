//
//  ViewController.swift
//  HelloWorld
//
//  Created by admin on 07/02/2020.
//  Copyright © 2020 Markus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var output: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
        if let name = txtField.text {
            output.text = "Hello \(name)"
        }
    }
    
}

