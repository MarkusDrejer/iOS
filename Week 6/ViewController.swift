//
//  ViewController.swift
//  HelloWorld
//
//  Created by admin on 07/02/2020.
//  Copyright © 2020 Markus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // New to make the 'OK' buttons on the Contact and About page properly unwind
    // the Segue making the page close instad of opening another on top of it
    @IBAction func unwindContacts(unwindSegue: UIStoryboardSegue){}
    @IBAction func unwindAbout(unwindSegue: UIStoryboardSegue){}
    
}

