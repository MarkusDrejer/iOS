//
//  ViewController.swift
//  MediaCaptureDemo
//
//  Created by admin on 27/03/2020.
//  Copyright © 2020 Markus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var resizeHeight: UITextField!
    @IBOutlet weak var resizeWidth: UITextField!
    @IBOutlet weak var resizeBtn: UIButton!
    @IBOutlet weak var addTextBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    var imagePicker = UIImagePickerController() // Will handle the task of fetching an image from iOS system
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self // Assign the object from this class to handle image picking return
    }
    
    override func viewWillAppear(_ animated: Bool) {
        inputTextField.placeholder = "Add text to image"
        resizeHeight.placeholder = "Height"
        resizeWidth.placeholder = "Width"
        inputTextField.isHidden = true
        addTextBtn.isHidden = true
        saveBtn.isHidden = true
        resizeHeight.isHidden = true
        resizeWidth.isHidden = true
        resizeBtn.isHidden = true    }

    @IBAction func photosBtnPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary // What type of of task: camera or photoalbum
        imagePicker.allowsEditing = true // Allows the user to edit the photo before getting the image
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraPhotoBtnPressed(_ sender: UIButton) {
        imagePicker.sourceType = .camera
        imagePicker.showsCameraControls = true
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraVideoBtnPressed(_ sender: UIButton) {
        imagePicker.mediaTypes = ["public.movie"] // will launch the video in the camera app
        imagePicker.videoQuality = .typeMedium
        
        imagePicker.sourceType = .camera
        imagePicker.showsCameraControls = true
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let url = info[.mediaURL] as? URL { // will only be true if there is a video
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path) {
                UISaveVideoAtPathToSavedPhotosAlbum(url.path, nil, nil, nil)
            }
        } else { // if it is an image
            let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            imageView.image = image
            picker.dismiss(animated: true, completion: nil)
        }
        inputTextField.isHidden = false
        addTextBtn.isHidden = false
        saveBtn.isHidden = false
        resizeHeight.isHidden = false
        resizeWidth.isHidden = false
        resizeBtn.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touches began")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let p = touches.first?.location(in: view) {
            print("moved to: \(p)")
            imageView.transform = CGAffineTransform(translationX: p.x, y: 0)
        }
    }
    
    @IBAction func addtextBtnPressed(_ sender: UIButton) {
        let textToAdd = inputTextField.text!
        let formattedText = NSAttributedString(string: textToAdd, attributes: [.font:UIFont(name: "Georgia", size: 100)!, .foregroundColor: UIColor.white])
        let textSize = imageView.image!.size
        let graphics = UIGraphicsImageRenderer(size: textSize)
        imageView.image = graphics.image { _ in
            imageView.image!.draw(at: .zero)
            formattedText.draw(at: CGPoint(x: 30, y: textSize.height-150))
        }
    }
    
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, nil, nil, nil)
    }
    
    @IBAction func resizeBtnPressed(_ sender: UIButton) {
        guard let CGHeight = NumberFormatter().number(from: resizeHeight.text!) else { return }
        guard let CGWidth = NumberFormatter().number(from: resizeWidth.text!) else { return }
        
        imageView.image = resizeImage(image: imageView.image!, targetSize: CGSize(width: CGFloat(truncating: CGWidth), height: CGFloat(truncating: CGHeight)))
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)

        UIGraphicsBeginImageContextWithOptions(targetSize, false, 0.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
