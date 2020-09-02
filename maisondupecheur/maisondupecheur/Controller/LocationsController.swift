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
    
    // Type location selected by user
    var typeLocation: String!
    
    // All locations with the type selected
    private var locations = [Location]()
    
    // User choice of location
    private var locationChoosed: Location!
    
    // MARK: - Outlet
    
    @IBOutlet private weak var locationTableView: UITableView!
    
    // MARK: - Actions
    
    // User tap dismiss button
    @IBAction func tapDismissButton() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    // MARK: - Private function
    
    // Send the location choosed by user to next controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userWantsDetails", let nextController = segue.destination as? InfoLocationController {
            nextController.location = locationChoosed
        }
    }
    
    // Retrieve all location with the wanted type, init TableView within
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

// MARK: - Extensions for UITableView

// Configuration of TableView
extension LocationsController: UITableViewDataSource {
    
    // Init number of row in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    // Creation of tableView cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as? ResultLocationSearchCell else { return UITableViewCell() }
        cell.configure(with: locations[indexPath.row].title)
        return cell
    }
}

// When user tapped on tableView cell
extension LocationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        locationChoosed = locations[indexPath.row]
        self.performSegue(withIdentifier: "userWantsDetails", sender: nil)
    }
}
