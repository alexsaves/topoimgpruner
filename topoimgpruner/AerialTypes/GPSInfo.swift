//
//  GPSInfo.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/3/23.
//

import Foundation
import MapKit

/**
 * Holds basic drone GPS information
 */
struct GPSInfo {
    var lat:CLLocationCoordinate2D = CLLocationCoordinate2D(),
        long:CLLocationCoordinate2D = CLLocationCoordinate2D(),
        altitude: CLLocationCoordinate2D = CLLocationCoordinate2D()
}
