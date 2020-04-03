//
//  ViewController.swift
//  MapDemo2020
//
//  Created by admin on 20/03/2020.
//  Copyright © 2020 Markus. All rights reserved.
//

import UIKit
import MapKit
import FirebaseFirestore
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager() // will handle location (GPS, WIFI) updates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // ask user to approve location with the app
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer // precision of the location
        FirebaseRepo.startListener(vc: self)
        map.showsUserLocation = true
    }
    
    @IBAction func startUpdate(_ sender: UIButton) {
        locationManager.startUpdatingLocation() // start getting location data from the device continuously
    }
    
    @IBAction func stopUpdate(_ sender: UIButton) {
        locationManager.stopUpdatingLocation()
    }
    
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .ended {
            let touchPoint = sender.location(in: map)
            let newCoordinates = map.convert(touchPoint, toCoordinateFrom: map)
            let annotation = MKPointAnnotation()
            annotation.coordinate = newCoordinates
            
            let alert = UIAlertController(title: "New Location", message: "Please enter a name for this location", preferredStyle: .alert)
            alert.addTextField { (textField) in }
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
                guard let textField = alert?.textFields?[0], let title = textField.text else { return }
                annotation.title = title
                
                FirebaseRepo.addMarker(text: title, lat: newCoordinates.latitude, long: newCoordinates.longitude)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // startListener()
    func updateMarkers(snap: QuerySnapshot) {
        let markers = MapDataAdapter.getMKAnnotationsFromData(snap: snap)
        map.removeAnnotations(map.annotations)
        map.addAnnotations(markers)
    }
    
    @IBAction func signoutBtnPressed(_ sender: UIButton) {
        Authentication.signOut()
    }
    
}
extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coord = locations.last?.coordinate {
            let region = MKCoordinateRegion(center: coord, latitudinalMeters: 300, longitudinalMeters: 300)
            map.setRegion(region, animated: true) // will move the view
        }
    }
}
