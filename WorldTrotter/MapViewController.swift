//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Suliman Alsaid on 2/11/19.
//  Copyright © 2019 Suliman Alsaid. All rights reserved.
//

import UIKit
import MapKit

class MapViewController : UIViewController {
    
    var mapView: MKMapView!
    var location: UIButton!
    var pinButton: UIButton!
    var span: MKCoordinateSpan!
    var index: Int!
    let locationManager = CLLocationManager()
    var pins: [Pin] = [Pin(name: "Birth Place", location: CLLocationCoordinate2D(latitude: 24.7467, longitude: 46.6518)), Pin(name: "Where I am", location: CLLocationCoordinate2D(latitude: 36.151943, longitude: -79.876480)), Pin(name: "Interesting Location", location: CLLocationCoordinate2D(latitude: 40.7223, longitude: -73.9928))]
    
    
    
    override func loadView() {
        index = 0
        locationManager.requestAlwaysAuthorization()
        mapView = MKMapView()
        mapView.showsUserLocation = true
        span = mapView.region.span
        view = mapView
        
        location = UIButton(type: .system)
        location.setTitle("Location", for: .normal)
        location.translatesAutoresizingMaskIntoConstraints = false
        location.addTarget(self, action: #selector(MapViewController.locationPress(_:)), for: .touchUpInside)
        
        view.addSubview(location)
        
        let buttonBottom = NSLayoutConstraint(item: location, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1, constant: -23)
        let buttonCenter = NSLayoutConstraint(item: location, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.75, constant: 0)
        
        NSLayoutConstraint.activate([buttonBottom, buttonCenter])
        
        pinButton = UIButton(type: .system)
        pinButton.setTitle("Pins", for: .normal)
        pinButton.translatesAutoresizingMaskIntoConstraints = false
        pinButton.addTarget(self, action: #selector(MapViewController.pinButtonPress(_:)), for: .touchUpInside)
        
        view.addSubview(pinButton)
        
        let pinButtonBottom = NSLayoutConstraint(item: pinButton, attribute: .centerY, relatedBy: .equal, toItem: location, attribute: .centerY, multiplier: 1, constant: -30)
        let pinButtonCenter = NSLayoutConstraint(item: pinButton, attribute: .centerX, relatedBy: .equal, toItem: location, attribute: .centerX, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([pinButtonBottom, pinButtonCenter])
        
        
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)

        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Map Loaded!")
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
            
            
        }
    }
    
    @objc func locationPress(_ button: UIButton) {
        mapView.setRegion(MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)), animated: true)
        
    }
    
    @objc func pinButtonPress(_ button: UIButton) {
        if(mapView.annotations.count > 0) {
            mapView.removeAnnotations(mapView.annotations)
        }
        
        let pin = MKPointAnnotation()
        pin.coordinate = pins[index].location
        pin.title = pins[index].name
        mapView.addAnnotation(pin)
        
        if(index != 2) {
        mapView.setRegion(MKCoordinateRegion(center: pins[index].location, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)), animated: true)
        }
        else {
            mapView.setRegion(MKCoordinateRegion(center: pins[index].location, span: MKCoordinateSpan(latitudeDelta: 0.0007, longitudeDelta: 0.0007)), animated: true)
        }
        
        if(index < 2) {
            index = index + 1
        } else {
            index = 0
        }
    }
    
    struct Pin {
        var name: String
        var location: CLLocationCoordinate2D
        
    }
    
}

