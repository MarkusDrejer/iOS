//
//  CloudStorage.swift
//  FirebaseHelloWorld
//
//  Created by admin on 28/02/2020.
//  Copyright © 2020 Markus. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class CloudStorage {
    
    private static var list = [Note]()
    private static let db = Firestore.firestore()
    private static let storage = Storage.storage() //Get instance of storage
    private static let notes = "notes"
    
    
    static func downloadImage(name: String, imgView: UIImageView) {
        let imgRef = storage.reference(withPath: name) // Get "filehandle"
        imgRef.getData(maxSize: 10000000) { (data, error) in
            print("success downloading image!")
            let img = UIImage(data: data!)
            DispatchQueue.main.async { // Prevent background thread from interrupting the main thread, which handles user inputs
                imgView.image = img;
            }
        }
    }
    
    static func uploadImageData(data: Data, serverFileName: String) -> Void {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        // Create a reference to the file you want to upload
        let fileRef = storageRef.child(serverFileName)
        fileRef.putData(data, metadata: nil)
    }
    
    static func startListener(tableView: UITableView) {
        print("starting listener")
        db.collection(notes).addSnapshotListener{ (snap, error) in
            if error == nil {
                self.list.removeAll()
                for note in snap!.documents {
                    let map = note.data()
                    let head = map["head"] as! String
                    let body = map["body"] as! String
                    let img = map["img"] as! String
                    let newNote = Note(id: note.documentID, head: head, body: body, img: img)
                    self.list.append(newNote)
                }
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
    }
    
    static func getData(index: Int) -> Note {
        return self.list[index]
    }
    
    static func deleteData(index: Int) {
        self.list.remove(at: index)
    }
    
    static func getSize() -> Int{
        self.list.count
    }
    
    static func createNote(head:String, body:String, img:String) {
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
        map["img"] = img
        db.collection(notes).addDocument(data: map)
    }
    
    static func deleteNote(id:String) {
        let docRef = db.collection(notes).document(id)
        docRef.delete()
    }
    
    static func updateNote(index:Int, head:String, body:String, img:String) {
        let note = list[index]
        let docRef = db.collection(notes).document(note.id)
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
        map["img"] = img
        docRef.setData(map)
    }
}
