//
//  MapDataAdapter.swift
//  MapDemo2020
//
//  Created by admin on 20/03/2020.
//  Copyright © 2020 Markus. All rights reserved.
//

import Foundation
import FirebaseFirestore
import MapKit

class MapDataAdapter {
    
    static func getMKAnnotationsFromData(snap: QuerySnapshot) -> [MKPointAnnotation] {
        var markers = [MKPointAnnotation]()
        for doc in snap.documents {
            let map = doc.data()
            let text = map["text"] as! String
            let geoPoint = map["coordinates"] as! GeoPoint
            let mkAnnotation = MKPointAnnotation()
            mkAnnotation.title = text
            let coordinate = CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude)
            mkAnnotation.coordinate = coordinate
            markers.append(mkAnnotation)
        }
        return markers
    }
}
