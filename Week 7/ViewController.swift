//
//  ViewController.swift
//  MyNotebook
//
//  Created by admin on 14/02/2020.
//  Copyright © 2020 Markus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var textToSave: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    var theText = "Please write here...";
    var textArray = [String](); // Empty String array
    var preLoadArray = ["first", "second", "third"];
    var edit = false;
    var index = 0;
    let fileName = "theString.txt";
    
    override func viewDidLoad() {
        super.viewDidLoad() // Only gets called the first the app is launched
        tableView.dataSource = self;
        tableView.delegate = self;
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textToSave.text = theText;
        for i in preLoadArray {
            textArray.append(i);
        }
    }

    @IBAction func saveBtn(_ sender: UIButton) {
        theText = textToSave.text;
        if edit {
            textArray[index] = theText;
        } else {
            textArray.append(theText);
        }
        updateTable();
        saveStringToFile(input: theText, fileName: fileName);
        print(readStringFromFile(fileName: fileName));
    }
    
    @IBAction func deleteBtn(_ sender: UIButton) {
        if edit {
            textArray.remove(at: index)
            updateTable();
        }
    }
    
    func updateTable() {
        tableView.reloadData();
        edit = false;
        textToSave.text = "";
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
        textToSave.text = textArray[indexPath.row];
        edit = true;
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
}
