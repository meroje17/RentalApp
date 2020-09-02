//
//  Location.swift
//  maisondupecheur
//
//  Created by Jérôme Guèrin on 25/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import Foundation

// All types of location around the house
enum LocationType: String {
    case visit = "À visiter"
    case restaurant = "Restaurants"
    case tasting = "Dégustations"
    case beach = "Plages"
    case service = "Services"
    case market = "Supermarchés"
}

// MARK: - Struct for decode JSON

struct LocationJSON: Decodable {
    let detailJSON: [DetailJSON]
}

struct DetailJSON: Decodable {
    let name, detail, url, type, image: String
}

// MARK: - Object Location

final class Location {
    
    // MARK: - Properties
    
    // All location loading with Locations.json
    static var list : [Location] {
        return convert(json: loadJSON())
    }
    
    // Properties to pretend be Location
    var type: LocationType
    var title: String
    var body: String
    var url: String
    var image: String
    
    // MARK: - Initializer
    
    init(type: LocationType, title: String, body: String, url: String, image: String) {
        self.type = type
        self.title = title
        self.body = body
        self.url = url
        self.image = image
    }
    
    // MARK: - Private function
    
    // Loading JSON from Locations.json
    static private func loadJSON() -> [DetailJSON] {
        let decoder = JSONDecoder()
        guard let url = Bundle.main.url(forResource: "Locations", withExtension: "json") else { return [DetailJSON]() }
        guard let data = try? Data(contentsOf: url) else { return [DetailJSON]() }
        guard let result = try? decoder.decode(LocationJSON.self, from: data) else { return [DetailJSON]() }
        return result.detailJSON
    }
    
    // Transform detailsJSON on Location
    static private func convert(json: [DetailJSON]) -> [Location] {
        var locations = [Location]()
        for detail in json {
            var type: LocationType!
            switch detail.type {
            case "À visiter":
                type = .visit
            case "Restaurants":
                type = .restaurant
            case "Dégustations":
                type = .tasting
            case "Plages":
                type = .beach
            case "Services":
                type = .service
            case "Supermarchés":
                type = .market
            default:
                return locations
            }
            locations.append(Location(type: type, title: detail.name, body: detail.detail, url: detail.url, image: detail.image))
        }
        return locations
    }
}
