//
//  HomeController.swift
//  maisondupecheur
//
//  Created by Jérôme Guèrin on 20/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit
import MapKit

enum InfosChoice {
    case infos, weather, pictures, phone, mail, adress
}

final class HomeController: UIViewController {

    // MARK: - Properties
    
    private var infosChoice: InfosChoice!
    
    // MARK: - Outlets

    @IBOutlet private weak var houseImage: UIImageView!
    @IBOutlet private weak var houseMap: MKMapView!
    @IBOutlet private var allButtons: [UIButton]!
    @IBOutlet private var allStackViews: [UIStackView]!
    @IBOutlet private weak var backgroundInfoView: UIView!
    
    // In stack view infos :
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var indexPage: UIPageControl!
    @IBOutlet private weak var houseImages: UIImageView!
    @IBOutlet private weak var buttonArrowLeft: UIButton!
    @IBOutlet private weak var buttonArrowRight: UIButton!
    
    // MARK: - Initializer

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
    }
    
    // MARK: - Action
    
    @IBAction func tappOnButtons(_ sender: UIButton) {
        animateToHideOnLeft()
    }
    
    @IBAction func tapLocationAround() {
        animateToHideLittleButtons()
    }
    
    @IBAction func tapDismissButton() {
        showAllButtons()
    }
    
    // MARK: - Private functions
    
    private func initUI() {
        setUpUI()
    }
    
    private func setUpUI() {
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
        
        for button in allButtons {
            button.layer.cornerRadius = 20
            button.layer.borderWidth = 3
            button.layer.borderColor = UIColor.white.cgColor
        }
        backgroundInfoView.layer.cornerRadius = 20
        backgroundInfoView.layer.borderWidth = 3
        backgroundInfoView.layer.borderColor = UIColor.white.cgColor
        
        indexPage.isUserInteractionEnabled = false
    }
    
    private func animateToHideOnLeft() {
        UIView.animate(withDuration: 0.3, animations: {
            self.allStackViews[0].transform = CGAffineTransform(translationX: -200, y: 0)
            self.allStackViews[0].layer.opacity = 0
        }) { (_) in
            UIView.animate(withDuration: 0.3, animations: {
                self.allStackViews[1].transform = CGAffineTransform(translationX: -200, y: 0)
                self.allStackViews[1].layer.opacity = 0
            }) { (_) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.allStackViews[2].transform = CGAffineTransform(translationX: -200, y: 0)
                    self.allStackViews[2].layer.opacity = 0
                }) { (_) in
                    self.backgroundInfoView.isHidden = false
                }
            }
        }
    }
    
    private func animateToHideLittleButtons() {
        allStackViews[1].isHidden = true
        allStackViews[2].isHidden = true
        UIView.animate(withDuration: 1.2) {
            self.allStackViews[0].transform = CGAffineTransform(translationX: -200, y: 0)
            self.allStackViews[0].layer.opacity = 0
        }
    }
    
    private func returnHome() {
        allStackViews[1].isHidden = false
        allStackViews[2].isHidden = false
        UIView.animate(withDuration: 1.2) {
            self.allStackViews[0].transform = .identity
            self.allStackViews[0].layer.opacity = 1
        }
    }
    
    private func showAllButtons() {
        backgroundInfoView.isHidden = true
        UIView.animate(withDuration: 0.3, animations: {
            self.allStackViews[0].transform = .identity
            self.allStackViews[0].layer.opacity = 1
        }) { (_) in
            UIView.animate(withDuration: 0.3, animations: {
                self.allStackViews[1].transform = .identity
                self.allStackViews[1].layer.opacity = 1
            }) { (_) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.allStackViews[2].transform = .identity
                    self.allStackViews[2].layer.opacity = 1
                })
            }
        }
    }
}

