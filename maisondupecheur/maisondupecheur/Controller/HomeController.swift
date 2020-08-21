//
//  HomeController.swift
//  maisondupecheur
//
//  Created by Jérôme Guèrin on 20/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit
import MapKit

final class HomeController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Outlets

    @IBOutlet private weak var houseImage: UIImageView!
    @IBOutlet private weak var houseMap: MKMapView!
    @IBOutlet private var buttonToRounded: [UIButton]!
    
    // MARK: - Initializer

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
    }
    
    // MARK: - Private functions
    
    private func initUI() {
        houseImage.layer.cornerRadius = houseImage.bounds.height/2
        houseImage.layer.borderWidth = 4
        houseImage.layer.borderColor = UIColor.white.cgColor
        
        let basicLocation = CLLocationCoordinate2D(latitude: 45.72175979614258, longitude: -1.1450577974319458)
        let regionLatitudeMeters: CLLocationDistance = 1000
        let regionLongitudeMeters: CLLocationDistance = 1000
        let region = MKCoordinateRegion(center: basicLocation, latitudinalMeters: regionLatitudeMeters, longitudinalMeters: regionLongitudeMeters)
        houseMap.mapType = .satellite
        houseMap.setRegion(region, animated: true)
        houseMap.isUserInteractionEnabled = false
        
        for button in buttonToRounded {
            button.layer.cornerRadius = 20
            button.layer.borderWidth = 4
            button.layer.borderColor = UIColor.white.cgColor
        }
    }
}

