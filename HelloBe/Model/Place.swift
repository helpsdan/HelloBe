//
//  Place.swift
//  HelloBe
//
//  Created by Daniel Aguiar on 20/9/18.
//  Copyright © 2018 Daniel Aguiar. All rights reserved.
//

import Foundation
import MapKit

struct Place {
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    var coordinate: CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
