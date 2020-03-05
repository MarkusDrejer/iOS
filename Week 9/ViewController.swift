//
//  ViewController.swift
//  FirebaseHelloWorld
//
//  Created by admin on 28/02/2020.
//  Copyright © 2020 Markus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var noteTable: UITableView!
    
    var tableItems = [String]()
    var cloudArray = [Note]()
    var index = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CloudStorage.startListener()
        noteTable.dataSource = self;
        noteTable.delegate = self;
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        let seconds = 0.1
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.cloudArray = CloudStorage.getData()
            for note in self.cloudArray {
                self.tableItems.append(note.head)
            }
            self.noteTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1");
        cell?.textLabel?.text = tableItems[indexPath.row];
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row;
        performSegue(withIdentifier: "details", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CloudStorage.deleteNote(id: cloudArray[indexPath.row].id)
            tableItems.remove(at: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: .fade);
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destViewController : ViewController2 = segue.destination as! ViewController2;
        if index != -1 {
            destViewController.head = cloudArray[index].head
            destViewController.body = cloudArray[index].body
        }
    }
    
    @IBAction func cancel(_ unwindSegue: UIStoryboardSegue) {}
}

