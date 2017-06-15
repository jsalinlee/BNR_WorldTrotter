//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Jonathan Salin Lee on 6/8/17.
//  Copyright © 2017 Salin Studios. All rights reserved.
//

import UIKit;
import MapKit;

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    
    var mapView: MKMapView!;
    var locationManager: CLLocationManager!;
    
    override func loadView() {
        // Create a map view
        mapView = MKMapView();
        mapView.delegate = self;
        locationManager = CLLocationManager();
        locationManager.delegate = self;
        
        var annotations: [Annotation] = [];
        let bornCoordinates = CLLocationCoordinate2D(latitude: 37.369, longitude: -122.082);
        let bornAnnotation = Annotation(title: "Born Here", subtitle: "April 30, 1994", coordinate: bornCoordinates);
        let currentCoordinates = CLLocationCoordinate2D(latitude: 37.375, longitude: -121.910);
        let currentAnnotation = Annotation(title: "Currently Here", subtitle: "Working at Coding Dojo", coordinate: currentCoordinates);
        let visitedCoordinates = CLLocationCoordinate2D(latitude: 43.722, longitude: 10.394);
        let visitedAnnotation = Annotation(title: "Visited Here", subtitle: "Vacation 2006", coordinate: visitedCoordinates);
        annotations.append(bornAnnotation);
        annotations.append(currentAnnotation);
        annotations.append(visitedAnnotation);
        
        mapView.addAnnotations(annotations);
        // Set it as *the* view of this view controller
        view = mapView;
        
        let standardString = NSLocalizedString("Standard", comment: "Standard map view");
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view");
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view");
        let segmentedControl = UISegmentedControl(items: [standardString, satelliteString, hybridString]);
        
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5);
        segmentedControl.selectedSegmentIndex = 0;
        
        segmentedControl.addTarget(self,
                                   action: #selector(MapViewController.mapTypeChanged(_:)),
                                   for: .valueChanged);
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false;
        view.addSubview(segmentedControl);
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8);
        let margins = view.layoutMarginsGuide;
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor);
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor);
        
        topConstraint.isActive = true;
        leadingConstraint.isActive = true;
        trailingConstraint.isActive = true;
        
        initUserLocationButton(segmentedControl);
    }
    
    func initUserLocationButton(_ anyView: UIView!) {
        
        let userLocationButton = UIButton.init(type: .system);
        userLocationButton.setTitle("Current Location", for: .normal);
        
        userLocationButton.addTarget(self,
                                     action: #selector(MapViewController.showUserLocation(_:)),
                                     for: .touchUpInside);
        
        userLocationButton.translatesAutoresizingMaskIntoConstraints = false;
        
        view.addSubview(userLocationButton);
        
        let topButtonConstraint = userLocationButton.topAnchor.constraint(equalTo: anyView.topAnchor, constant: 32);
        let leadingButtonConstraint = userLocationButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor);
        let trailingButtonConstraint = userLocationButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor);
        
        topButtonConstraint.isActive = true;
        leadingButtonConstraint.isActive = true;
        trailingButtonConstraint.isActive = true;
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        print("MapViewController loaded its view.");
    }
    
    func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard;
        case 1:
            mapView.mapType = .hybrid;
        case 2:
            mapView.mapType = .satellite;
        default:
            break;
        }
    }
    
    func showUserLocation(_ sender: UIButton) {
        print("Request location permission here");
        locationManager.requestWhenInUseAuthorization();
        mapView.showsUserLocation = true;
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let zoomedInCurrentLocation = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 500, 500);
        mapView.setRegion(zoomedInCurrentLocation, animated: true);
    }
    
    func mapView(_mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
        return annotationView;
    }
}
