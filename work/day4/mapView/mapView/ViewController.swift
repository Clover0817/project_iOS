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

    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span :Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        myMap.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span :Double, title strTitle: String, subtitle strSubtitle:String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
    }
//    private func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let pLocation = locations.last
//        goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.startUpdatingLocation()
        
        let pLocation = locations.last
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01) // _로 return값 받음
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            let pm = placemarks!.first
            let country = pm!.country
            var address:String = country!
            if pm!.locality != nil {
                address += " "
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil {
                address += " "
                address += pm!.thoroughfare!
            }
            
            self.lblLocationInfo1.text = "현재 위치"
            self.lbllocationInfo2.text = address
        })
        
        locationManager.stopUpdatingLocation()
    }
    
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
            if sender.selectedSegmentIndex == 0 {
                locationManager.startUpdatingLocation()
            } else if sender.selectedSegmentIndex == 1 {
                setAnnotation(latitudeValue: 37.512727, longitudeValue: 127.056837, delta: 0.1, title: "코엑스 스타필드", subtitle: "서울특별시 강남구 삼성로")
                self.lblLocationInfo1.text = "보고 계신 위치"
                self.lbllocationInfo2.text = "코엑스"
            } else if sender.selectedSegmentIndex == 2 {
                setAnnotation(latitudeValue: 37.35533, longitudeValue: 126.9014066, delta: 0.1, title: "역삼역", subtitle: "서울특별시 강남구 테헤란로")
                self.lblLocationInfo1.text = "보고 계신 위치"
                self.lbllocationInfo2.text = "역삼역"
            } else if sender.selectedSegmentIndex == 3 {
                setAnnotation(latitudeValue: 37.501394, longitudeValue: 127.058472, delta: 0.1, title: "우리집", subtitle: "서울특별시 강남구 삼성로67길")
                self.lblLocationInfo1.text = "보고 계신 위치"
                self.lbllocationInfo2.text = "우리집"
            }
    }
}

