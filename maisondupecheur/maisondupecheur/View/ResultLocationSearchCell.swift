//
//  ResultLocationSearchCell.swift
//  maisondupecheur
//
//  Created by Jérôme Guèrin on 25/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

final class ResultLocationSearchCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var viewToRounded: UIView!
    @IBOutlet private weak var nameOfLocation: UILabel!
    
    // MARK: - Initializer
    
    func configure(with name: String) {
        viewToRounded.layer.cornerRadius = 10
        nameOfLocation.text = name
    }
}
