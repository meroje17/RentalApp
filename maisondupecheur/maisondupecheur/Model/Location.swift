//
//  Location.swift
//  maisondupecheur
//
//  Created by Jérôme Guèrin on 25/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import Foundation

enum LocationType: String {
    case visit = "À visiter"
    case restaurant = "Restaurants"
    case tasting = "Dégustations"
    case beach = "Plages"
    case service = "Services"
    case market = "Supermarchés"
}

// MARK: - Mamacita
struct LocationJSON: Codable {
    let detailJSON: [DetailJSON]
}

// MARK: - DetailJSON
struct DetailJSON: Codable {
    let name, detail, url, type, image: String
}


final class Location {
    
    // MARK: - Properties
    
    static var list : [Location] {
        return convert(json: loadJSON())
    }
    
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
    
    static private func loadJSON() -> [DetailJSON] {
        let decoder = JSONDecoder()
        guard let url = Bundle.main.url(forResource: "Locations", withExtension: "json") else { return [DetailJSON]() }
        guard let data = try? Data(contentsOf: url) else { return [DetailJSON]() }
        guard let result = try? decoder.decode(LocationJSON.self, from: data) else { return [DetailJSON]() }
        return result.detailJSON
    }
    
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
