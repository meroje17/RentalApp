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
    
    private let house = House()
    private var imageIndex = 0
    
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
    @IBOutlet private weak var stackButton: UIButton!
    
    // MARK: - Initializer

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
    }
    
    // MARK: - Action
    
    @IBAction func tappOnButtons(_ sender: UIButton) {
        animateToHideOnLeft()
        tapOnButton(sender.tag)
    }
    
    @IBAction func tapLocationAround() {
        animateToHideLittleButtons()
    }
    
    @IBAction func tapActionButton() {
        if let url = URL(string: "tel://\(house.phoneNumber)") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func tapDismissButton() {
        showAllButtons()
    }
    
    @IBAction func tapArrowButtons(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            imageIndex -= 1
            setUpImageStack()
        case 1:
            imageIndex += 1
            setUpImageStack()
        default:
            return
        }
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
        let regionLatitudeMeters: CLLocationDistance = 15000
        let regionLongitudeMeters: CLLocationDistance = 15000
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
        stackButton.layer.cornerRadius = 10
        stackButton.layer.borderWidth = 2
        stackButton.layer.borderColor = UIColor.white.cgColor
        
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
    
    private func tapOnButton(_ number: Int) {
        switch number {
        case 2:
            hideAllImageSystem(false)
            setUpImageStack()
        case 1, 3, 4, 5:
            hideAllImageSystem(true)
            setUpLabels(number)
        default:
            return()
        }
    }
    
    private func hideAllImageSystem(_ bool: Bool) {
        indexPage.isHidden = bool
        houseImages.isHidden = bool
        buttonArrowLeft.isHidden = bool
        buttonArrowRight.isHidden = bool
        bodyLabel.isHidden = !bool
    }
    
    private func setUpLabels(_ number: Int) {
        bodyLabel.font = UIFont(name: "Verdana", size: 20)
        bodyLabel.textAlignment = .center
        stackButton.isHidden = true
        switch number {
        case 1:
            titleLabel.text = "INFOS"
            bodyLabel.text = house.infos
            bodyLabel.font = UIFont(name: "Verdana", size: 12)
            bodyLabel.textAlignment = .justified
        case 3:
            titleLabel.text = "TÉLÉPHONE"
            bodyLabel.text = house.phoneNumber
            stackButton.isHidden = false
            stackButton.setTitle("APPELER", for: .normal)
        case 4:
            titleLabel.text = "MAIL"
            bodyLabel.text = house.mail
        case 5:
            titleLabel.text = "ADRESSE"
            bodyLabel.text = house.adress
        default:
            return
        }
    }
    
    private func setUpImageStack() {
        stackButton.isHidden = true
        titleLabel.text = "IMAGES"
        indexPage.currentPage = imageIndex
        if imageIndex == 0 {
            buttonArrowLeft.layer.opacity = 0
            buttonArrowLeft.isUserInteractionEnabled = false
        } else {
            buttonArrowLeft.layer.opacity = 1
            buttonArrowLeft.isUserInteractionEnabled = true
        }
        if imageIndex == house.pictures.count-1 {
            buttonArrowRight.layer.opacity = 0
            buttonArrowRight.isUserInteractionEnabled = false
        } else {
            buttonArrowRight.layer.opacity = 1
            buttonArrowRight.isUserInteractionEnabled = true
        }
        houseImages.image = UIImage(named: house.pictures[imageIndex])
        houseImages.layer.borderWidth = 3
        houseImages.layer.borderColor = UIColor.white.cgColor
    }
}

