//
//  ViewController2.swift
//  MyNotebook
//
//  Created by admin on 23/02/2020.
//  Copyright © 2020 Markus. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var noteTxt: UITextView!
    
    var theText = "Start here...";
    let fileName = "theString.txt";
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        noteTxt.text = theText;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destViewController : ViewController = segue.destination as! ViewController;
        
        theText = noteTxt.text;
        
        if destViewController.edit {
            destViewController.textArray[destViewController.index] = theText;
        } else {
            destViewController.textArray.append(theText);
        }
        destViewController.tableView.reloadData();
        destViewController.edit = false;
        
        destViewController.saveStringToFile(input: theText, fileName: fileName);
        print(destViewController.readStringFromFile(fileName: fileName));
    }
}
