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
            showUserLocation()
        }
    }
    var fetchingAlert: UIAlertController {
        let title = "Fetching..."
        let message = "Please wait while we fetch your location"
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    var fetchFailAlert: UIAlertController {
        let title = "Could not fetch location"
        let message = "Sorry, but it seems that we were unable to fetch your location. Please check your internet connection and location services"
        let action = UIAlertAction(title: "OK", style: .default)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(action)
        return alert
    }

    // MARK: - IBOutlet
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var selfLocationButton: UIButton!
    
    // MARK: - Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationButton()
    }
    
    func fetchUserLocation() {
        present(fetchingAlert, animated: true)
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
    
    func configureLocationButton() {
        selfLocationButton.layer.cornerRadius = 23
        selfLocationButton.layer.borderWidth = 0.5
        selfLocationButton.layer.borderColor = UIColor.gray.cgColor
    }
    
    func showUserLocation() {
        if let userAnnotation = userAnnotation {
            mapView.showAnnotations([userAnnotation], animated: true)
        } else {
            print("Could not add or show user's location annotation, location not found!")
        }
    }
    
    //MARK: - IBActions -
    @IBAction func selfLocationButtonTapped(_ sender: UIButton) {
        fetchUserLocation()
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
        let userAnnotation = Annotation(title: "You :)", subtitle: "This is your location", coordinate: coordinate)
        self.userAnnotation = userAnnotation
        
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        DispatchQueue.main.async {
            self.dismiss(animated: true)
            self.present(self.fetchFailAlert, animated: true)
        }
    }
    
}


