//
//  MapViewController.swift
//  bnrg_2_world_trotter
//
//  Created by Roman Brazhnikov on 22.05.2018.
//  Copyright © 2018 Roman. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController{
    
    var mapView: MKMapView!
    
    override func loadView() {
        // new map view
        mapView = MKMapView();
        // setting it is the view
        view = mapView
        
        // segmented control
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5) // translucent
        segmentedControl.selectedSegmentIndex = 0 // first (left) option
        
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        // constraints
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        //let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        
        let margins = view.layoutMarginsGuide
        
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    override func viewDidLoad() {
        print("Map view controller loaded")
    }
    
    @objc func mapTypeChanged(_ segControl:UISegmentedControl){
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
}
