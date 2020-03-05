//
//  ViewController2.swift
//  FirebaseHelloWorld
//
//  Created by admin on 28/02/2020.
//  Copyright © 2020 Markus. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var headTxt: UITextField!
    @IBOutlet weak var bodyTxt: UITextView!
    
    var head = "Write headline here..."
    var body = "Write body here..."

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        headTxt.text = head
        bodyTxt.text = body
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destViewController : ViewController = segue.destination as! ViewController;
        
        head = headTxt.text!
        body = bodyTxt.text
        
        if destViewController.index == -1 {
            CloudStorage.createNote(head: head, body: body)
            destViewController.tableItems.append(head)
        } else {
            CloudStorage.updateNote(index: destViewController.index, head: head, body: body)
            destViewController.tableItems[destViewController.index] = head
        }
        destViewController.noteTable.reloadData()
        destViewController.index = -1
    }
}
