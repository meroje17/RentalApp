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
    
    private var types = ["À visiter", "Restaurants", "Dégustations", "Plages", "Services", "Supermarchés"]
    private var locationChoice: String = String()
    
    // MARK: - Outlet
    
    @IBOutlet private var buttons: [UIButton]!
    
    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    // MARK: - Action
    
    @IBAction func tapDismissButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapLocationButtons(_ sender: UIButton) {
        locationChoice = types[sender.tag]
        self.performSegue(withIdentifier: "locationTypeChoosed", sender: nil)
    }
    
    // MARK: - Private functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "locationTypeChoosed", let nextController = segue.destination as? LocationsController {
            nextController.typeLocation = locationChoice
        }
    }
    
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
