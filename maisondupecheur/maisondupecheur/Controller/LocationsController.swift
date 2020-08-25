//
//  LocationsController.swift
//  maisondupecheur
//
//  Created by Jérôme Guèrin on 25/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import UIKit

final class LocationsController: UIViewController {

    // MARK: - Properties
    
    var typeLocation: String!
    private var locations = [Location]()
    private var locationChoosed: Location!
    
    // MARK: - Outlet
    
    @IBOutlet private weak var locationTableView: UITableView!
    
    // MARK: - Actions
    
    @IBAction func tapDismissButton() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    // MARK: - Private function
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userWantsDetails", let nextController = segue.destination as? InfoLocationController {
            nextController.location = locationChoosed
        }
    }
    
    private func initUI() {
        for location in Location.list {
            if location.type.rawValue == typeLocation {
                locations.append(location)
            }
        }
        let nib = UINib(nibName: "ResultLocationSearchCell", bundle: .main)
        locationTableView.register(nib, forCellReuseIdentifier: "LocationCell")
        locationTableView.dataSource = self
        locationTableView.delegate = self
    }
}

extension LocationsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as? ResultLocationSearchCell else { return UITableViewCell() }
        cell.configure(with: locations[indexPath.row].title)
        return cell
    }
}

extension LocationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        locationChoosed = locations[indexPath.row]
        self.performSegue(withIdentifier: "userWantsDetails", sender: nil)
    }
}
