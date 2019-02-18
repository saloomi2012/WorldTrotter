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
    var span: MKCoordinateSpan!
    
    let locationManager = CLLocationManager()

    
    override func loadView() {
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
    
    
}
