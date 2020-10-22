//
//  MapViewController.swift
//  BW4MortgageCalculator
//
//  Created by Clayton Watkins on 10/14/20.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    //MARK: - Properties -
    var userAnnotation: MKAnnotation? {
        didSet {
            mapView.addAnnotation(userAnnotation!)
        }
    }

    // MARK: - IBOutlet
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserLocation()
    }
    
    func fetchUserLocation() {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
} //End of class

//MARK: - Extensions -

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "") {
            annotationView.annotation = annotation
            annotationView.canShowCallout = true
            return annotationView
        }
        else {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "")
            annotationView.annotation = annotation
            annotationView.canShowCallout = true
            return annotationView
        }
        
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let userAnnotation = Annotation(title: nil, subtitle: nil, coordinate: coordinate)
        self.userAnnotation = userAnnotation
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
}


