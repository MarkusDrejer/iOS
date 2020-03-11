//
//  ViewController2.swift
//  FirebaseHelloWorld
//
//  Created by admin on 28/02/2020.
//  Copyright © 2020 Markus. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var headTxt: UITextField!
    @IBOutlet weak var bodyTxt: UITextView!
    @IBOutlet weak var imgTextField: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    var head = "Write headline here..."
    var body = "Write body here..."
    var imgText = ""
    var index = -1
    var chosenImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        headTxt.text = head
        bodyTxt.text = body
        if index != -1 {
            CloudStorage.downloadImage(name: imgText, imgView: imgView)
        }
    }
    
    @IBAction func loadImg(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
            
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgView.image = pickedImage
            chosenImage = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destViewController : ViewController = segue.destination as! ViewController;
        
        head = headTxt.text!
        body = bodyTxt.text
        
        if chosenImage != nil {
            let generatedId = UUID().uuidString + ".jpg"
               CloudStorage.uploadImageData(data: chosenImage.jpegData(compressionQuality: 1.0)!, serverFileName: generatedId)
            
            imgText = generatedId
        }
        
        if destViewController.index == -1 {
            CloudStorage.createNote(head: head, body: body, img: imgText)
        } else {
            CloudStorage.updateNote(index: destViewController.index, head: head, body: body, img: imgText)
        }
        destViewController.noteTable.reloadData()
        destViewController.index = -1
    }
}
