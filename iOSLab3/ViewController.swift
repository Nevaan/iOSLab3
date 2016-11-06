//
//  ViewController.swift
//  iOSLab3
//
//  Created by Paweł Łosek on 06.11.2016.
//  Copyright © 2016 Paweł Łosek. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var clearAction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopButton.enabled = false
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            //locationManager.startUpdatingLocation()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //Button actions
    
    @IBAction func startAction(sender: AnyObject) {
        locationManager.startUpdatingLocation()
        startButton.enabled = false
        stopButton.enabled = true
        
    }
    
    @IBAction func stopAction(sender: AnyObject) {
        locationManager.stopUpdatingLocation()
        startButton.enabled = true
        stopButton.enabled = false
    }
    
    
    @IBAction func clearAction(sender: AnyObject) {
        mapView.removeAnnotations(mapView.annotations)
    }
    
    
    //Utils
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        mapView.addAnnotation(myAnnotation)
        
        var spanDelta = 0.0
        if let speed = locations.last?.speed where speed > 0 {
            spanDelta = speed/5000
        }
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: spanDelta, longitudeDelta: spanDelta))

        
        mapView.setRegion(region, animated: true)
    }
    
    
}

