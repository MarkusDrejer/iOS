//
//  FirebaseRepo.swift
//  MapDemo2020
//
//  Created by admin on 20/03/2020.
//  Copyright © 2020 Markus. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FirebaseRepo {
    
    private static let db = Firestore.firestore()
    private static let path = "locations"
    
    static func startListener(vc: ViewController) {
        print("listener started")
        //When there is result, call
        //vc.updateMarkers()
        db.collection(path).addSnapshotListener { (snap, error) in
            if error != nil { // check if there is an error, if so just return
                return
            }
            if let snap = snap {
                vc.updateMarkers(snap: snap)
            }
        }
    }
    
    static func addMarker(text: String, lat: Double, long: Double) {
        var map = [String : Any]()
        map["text"] = text
        map["coordinates"] = GeoPoint(latitude: lat, longitude: long)
        db.collection(path).addDocument(data: map)
    }
    
}
