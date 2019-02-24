//
//  CountryContactDetails.swift
//  KidsSaveOcean
//
//  Created by Oleg Ivaniv on 8/9/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit
import MapKit

struct CountryContact {
    let name: String
    let code: String
    let address: String?
    let coordinates: CLLocationCoordinate2D?
    
    init(name: String, code: String, address: String?, coordinates: CLLocationCoordinate2D?) {
        self.name = name
        self.code = code
        self.address = address
        self.coordinates = coordinates
    }
}
