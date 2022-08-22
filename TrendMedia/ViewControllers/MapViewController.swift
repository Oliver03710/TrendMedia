//
//  StartingViewController.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/07/22.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    
    // MARK: - Selectors
    
    @objc func filterFunction() {
        
    }
    
    
    // MARK: - Helper Functions
    
    func configureNaviUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "mappin.and.ellipse"), style: .plain, target: self, action: #selector(filterFunction))
    }
    

}


// MARK: - Autorization Functions

extension MapViewController {
    
    
    
    
    
}


// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
}


// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    
    
}
