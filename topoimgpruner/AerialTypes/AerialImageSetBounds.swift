//
//  AerialImageFileSetBounds.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/3/23.
//

import Foundation
import MapKit

/**
 * Defined minimum and maximum boundaries for a set of images
 */
struct AerialImageSetBounds {
    var min: CLLocationCoordinate2D
    var max: CLLocationCoordinate2D
    
    init(forMin: CLLocationCoordinate2D, forMax: CLLocationCoordinate2D) {
        min = forMin
        max = forMax
    }
}
