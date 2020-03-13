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
    var index = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTable.dataSource = self;
        noteTable.delegate = self;
        CloudStorage.startListener(tableView: noteTable)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.noteTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CloudStorage.getSize();
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if CloudStorage.getData(index: indexPath.row).hasImage() {
            if let cell = noteTable.dequeueReusableCell(withIdentifier: "cell2") as? TableViewCellTextAndImage {
                cell.myLabel.text = CloudStorage.getData(index: indexPath.row).head
                CloudStorage.downloadImage(name: CloudStorage.getData(index: indexPath.row).img, imgView: cell.myImageView)
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? TableViewCellOnlyText {
                cell.myLabel.text = CloudStorage.getData(index: indexPath.row).head;
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row;
        performSegue(withIdentifier: "details", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CloudStorage.deleteNote(id: CloudStorage.getData(index: indexPath.row).id)
            CloudStorage.deleteData(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade);
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CloudStorage.getData(index: indexPath.row).hasImage() ? 300 : 80 // ternary operator, If statement on one line
        // If the part before the ? is true, return the number just after the ?
        // Else return the number after the colon
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destViewController : ViewController2 = segue.destination as! ViewController2;
        if index != -1 {
            destViewController.head = CloudStorage.getData(index: index).head
            destViewController.body = CloudStorage.getData(index: index).body
            destViewController.imgText = CloudStorage.getData(index: index).img
        }
        destViewController.index = index
    }
    
    @IBAction func cancel(_ unwindSegue: UIStoryboardSegue) {}
}
