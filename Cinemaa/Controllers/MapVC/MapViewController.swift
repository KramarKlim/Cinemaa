//
//  MapViewController.swift
//  Cinemaa
//
//  Created by Клим on 26.08.2021.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    //MARK: Public property
    var model: MapModelProtocol! = MapModel()
    
    //MARK: IBOutlet
    @IBOutlet var locationMapView: MKMapView!
    
    //MARK: Override methods
    override func viewDidLoad() {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Карта"
        setUp()
        model.manager.requestWhenInUseAuthorization()
        model.manager.desiredAccuracy = kCLLocationAccuracyBest
        model.manager.distanceFilter = kCLDistanceFilterNone
        locationMapView.showsUserLocation = true
    }
    
    //MARK: Private method
    private func setUp() {
        locationMapView.addAnnotation(model.annotation)
        locationMapView.setRegion(model.region, animated: true)
    }
}

