//
//  ViewController2.swift
//  Sensors
//
//  Created by admin on 26/04/2020.
//  Copyright © 2020 Markus. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController2: UIViewController {
    
    @IBOutlet weak var arrow: UIImageView!
    var isActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrow.transform = arrow.transform.rotated(by: CGFloat(Double.pi / -2))
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        UIDevice.current.isProximityMonitoringEnabled = false
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func proxyPressed(_ sender: UIButton) {
        isActive = !isActive
        if isActive {
            UIDevice.current.isProximityMonitoringEnabled = true
        } else {
            UIDevice.current.isProximityMonitoringEnabled = false
        }
        
    }
}
