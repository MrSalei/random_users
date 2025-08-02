//
//  RandomUser.swift
//  RandomUsers
//
//  Created by Илья Салей on 1.08.25.
//

import Foundation

public struct RandomUser: Decodable {
    
    public struct Name: Decodable {
        public let title: String
        public let first: String
        public let last: String
    }
    
    public struct Coordinates: Decodable {
        public let latitude: String
        public let longitude: String
        
        public init(latitude: String, longitude: String) {
            self.latitude = latitude
            self.longitude = longitude
        }
    }
    
    public struct Location: Decodable {
        public let coordinates: Coordinates
    }
    
    public struct Picture: Decodable {
        public let thumbnail: String
    }
    
    public let fullName: String
    public let email: String
    public let coordinates: Coordinates
    public let thumbnail: String
    
    enum CodingKeys: CodingKey {
        case name
        case email
        case location
        case picture
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(
            keyedBy: CodingKeys.self
        )
        
        let name = try container.decode(
            RandomUser.Name.self,
            forKey: .name
        )
        
        self.fullName = name.title + " " + name.first + " " + name.last
        
        self.email = try container.decode(
            String.self,
            forKey: .email
        )
        
        let location = try container.decode(
            RandomUser.Location.self,
            forKey: .location
        )
        
        self.coordinates = location.coordinates
        
        let picture = try container.decode(
            Picture.self,
            forKey: .picture
        )
        
        self.thumbnail = picture.thumbnail
    }
    
    public init(
        fullName: String,
        email: String,
        coordinates: Coordinates,
        thumbnail: String
    ) {
        self.fullName = fullName
        self.email = email
        self.coordinates = coordinates
        self.thumbnail = thumbnail
    }
}
