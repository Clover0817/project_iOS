//
//  ViewController.swift
//  mapView
//
//  Created by CSMAC08 on 2023/06/27.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    @IBOutlet var myMap: MKMapView!
    @IBOutlet var lblLocationInfo1: UILabel!
    @IBOutlet var lbllocationInfo2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblLocationInfo1.text = ""
        lbllocationInfo2.text = ""
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        myMap.showsUserLocation = true
    }

    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span :Double) {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        myMap.setRegion(pRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
    }
    
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
    }
}

