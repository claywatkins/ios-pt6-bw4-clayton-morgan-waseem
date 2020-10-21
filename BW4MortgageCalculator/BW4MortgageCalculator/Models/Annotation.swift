//
//  HomeAnnotation.swift
//  BW4MortgageCalculator
//
//  Created by Waseem Idelbi on 10/20/20.
//

import Foundation
import MapKit

class Annotation: NSObject, MKAnnotation {
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    let subtitle: String?
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
    
}
