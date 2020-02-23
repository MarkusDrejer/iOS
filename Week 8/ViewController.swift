//
//  ViewController.swift
//  MyNotebook
//
//  Created by admin on 14/02/2020.
//  Copyright © 2020 Markus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var textArray = [String](); // Empty String array
    var preLoadArray = ["first", "second", "third"];
    var edit = false;
    var index = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad() // Only gets called the first the app is launched
        tableView.dataSource = self;
        tableView.delegate = self;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for i in preLoadArray {
            textArray.append(i);
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1");
        cell?.textLabel?.text = textArray[indexPath.row];
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row;
        edit = true;
        performSegue(withIdentifier: "details", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            textArray.remove(at: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: .fade);
        }
    }
    
    func saveStringToFile(input:String, fileName:String) {
        let filePath = getDocumentDir().appendingPathComponent(fileName);
        do {
            try input.write(to: filePath, atomically: true, encoding: .utf8);
            print("Successfull writing");
        } catch {
            print("Error writing string \(input)");
        }
    }
    
    func readStringFromFile(fileName:String) -> String {
        let filePath = getDocumentDir().appendingPathComponent(fileName);
        do {
            let string = try String(contentsOf: filePath, encoding: .utf8);
            return string;
        } catch {
            print("Error while reading fil " + fileName);
        }
        return "Empty";
    }
    
    func getDocumentDir() -> URL {
        let documentDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask);
        return documentDir[0];
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destViewController : ViewController2 = segue.destination as! ViewController2;
        
        if edit {
            destViewController.theText = textArray[index];
        }
    }
    
    @IBAction func cancel(_ unwindSegue: UIStoryboardSegue) {}
}
