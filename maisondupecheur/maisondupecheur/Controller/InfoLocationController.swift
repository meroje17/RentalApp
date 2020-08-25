//
//  InfoLocationController.swift
//  maisondupecheur
//
//  Created by Jérôme Guèrin on 25/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

final class InfoLocationController: UIViewController {

    // MARK: - Property
    
    var location: Location!
    
    // MARK: - Outlets
    
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var nameLocationLabel: UILabel!
    @IBOutlet weak var locationDetailLabel: UILabel!
    @IBOutlet weak var itinaryButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func tapDismissButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapOpenItinaryButton() {
        guard let url = URL(string: location.url) else { return }
        UIApplication.shared.open(url)
    }
    
    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    // MARK: - Private function
    
    private func initUI() {
        locationImage.image = UIImage(named: location.image)
        nameLocationLabel.text = location.title
        locationDetailLabel.text = location.body
        itinaryButton.layer.cornerRadius = 20
    }
}
