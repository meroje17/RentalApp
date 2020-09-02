//
//  LocationAroundController.swift
//  maisondupecheur
//
//  Created by Jérôme Guèrin on 21/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

final class LocationAroundController: UIViewController {

    // MARK: - Property
    
    // All types of location
    private var types = ["À visiter", "Restaurants", "Dégustations", "Plages", "Services", "Supermarchés"]
    
    // Choice type by user
    private var locationChoice: String = String()
    
    // MARK: - Outlet
    
    @IBOutlet private var buttons: [UIButton]!
    
    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    // MARK: - Action
    
    // User tap on dismiss button to return on preview controller
    @IBAction func tapDismissButton() {
        dismiss(animated: true, completion: nil)
    }
    
    // User tap on type of location button
    @IBAction func tapLocationButtons(_ sender: UIButton) {
        locationChoice = types[sender.tag]
        self.performSegue(withIdentifier: "locationTypeChoosed", sender: nil)
    }
    
    // MARK: - Private functions
    
    // Send type of location wanted to the next controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "locationTypeChoosed", let nextController = segue.destination as? LocationsController {
            nextController.typeLocation = locationChoice
        }
    }
    
    // Init user interface to rounded button and assign text 
    private func initUI() {
        var index = 0
        var indexType = 0
        for button in buttons {
            if index%2 == 0 {
                button.setTitle(types[indexType], for: .normal)
                indexType += 1
            }
            button.layer.cornerRadius = 10
            index += 1
        }
    }
}
