//
//  CloudStorage.swift
//  FirebaseHelloWorld
//
//  Created by admin on 28/02/2020.
//  Copyright © 2020 Markus. All rights reserved.
//

import Foundation
import FirebaseFirestore

class CloudStorage {
    
    private static var list = [Note]()
    private static let db = Firestore.firestore()
    private static let notes = "notes"
    
    static func startListener() {
        print("starting listener")
        db.collection(notes).addSnapshotListener{ (snap, error) in
            if error == nil {
                self.list.removeAll()
                for note in snap!.documents {
                    let map = note.data()
                    let head = map["head"] as! String
                    let body = map["body"] as! String
                    let newNote = Note(id: note.documentID, head: head, body: body)
                    self.list.append(newNote)
                }
            }
        }
    }
    
    static func getData() -> [Note] {
        return self.list
    }
    
    static func createNote(head:String, body:String) {
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
        db.collection(notes).addDocument(data: map)
    }
    
    static func deleteNote(id:String) {
        let docRef = db.collection(notes).document(id)
        docRef.delete()
    }
    
    static func updateNote(index:Int, head:String, body:String) {
        let note = list[index]
        let docRef = db.collection(notes).document(note.id)
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
        docRef.setData(map)
    }
}
