//
//  MapModel.swift
//  Cinemaa
//
//  Created by Клим on 26.08.2021.
//

import Foundation
import MapKit

protocol MapModelProtocol {
    var locationManager: CLLocationManager { get }
    var manager: CLLocationManager { get }
    var annotation: MKPointAnnotation { get }
    var region: MKCoordinateRegion { get }
}

class MapModel: MapModelProtocol {
    
    var locationManager: CLLocationManager = CLLocationManager()
    
    var manager: CLLocationManager = CLLocationManager()
    
    var annotation: MKPointAnnotation = {
        let annotation = MKPointAnnotation()
        annotation.coordinate = DataManager.shared.coordinateCinema
        annotation.title = "ABOBA"
        return annotation
    }()
    
    var region: MKCoordinateRegion {
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        return region
    }
}
