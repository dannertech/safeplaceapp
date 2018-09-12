//
//  SosItem.swift
//  Colors
//
//  Created by Diamonique Danner on 8/1/18.
//  Copyright © 2018 Danner Opp., LLC. All rights reserved.
//

import Foundation

import FirebaseDatabase

struct SosItem {
    let ref : DatabaseReference?
    let key: String
    let longitude: Double
    let latitude: Double
    let clothingDescription : String
    let placeName : String
    let dropoffLocation : String
    
    
    init(key: String, longitude: Double, latitude: Double, clothingDescription: String, placeName: String, dropoffLocation: String) {
        self.ref = nil
        self.key = key
        self.longitude = longitude
        self.latitude = latitude
        self.clothingDescription = clothingDescription
        self.placeName = placeName
        self.dropoffLocation = dropoffLocation
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard
        let value = snapshot.value as? [String: AnyObject],
            
            let key = value["key"] as? String,
            let longitude = value["longitude"] as? Double,
            let dropoffLocation = value["dropoffLocation"] as? String,
            let clothingDescription = value["clothingDescription"] as? String,
            let placeName = value["placeName"] as? String,
            let latitude = value["latitude"] as? Double else {
                return nil
        }
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.latitude = latitude
        self.longitude = longitude
        self.clothingDescription = clothingDescription
        self.placeName = placeName
        self.dropoffLocation = dropoffLocation
        
    }
    
    func toAnyObject() -> Any {
        return [
            "key": key,
            "longitude": longitude,
            "latitude": latitude,
            "clothingDescription": clothingDescription,
            "placeName": placeName,
            "dropoffLocation": dropoffLocation
        ]
    }
}




