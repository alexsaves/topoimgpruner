//
//  AerialImageFileSetBounds.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/3/23.
//

import Foundation

/**
 * Defined minimum and maximum boundaries for a set of images
 */
struct AerialImageSetBounds {
    var minLatitude: GPSPoint = GPSPoint(),
        maxLatitude: GPSPoint = GPSPoint(),
        minLongitude: GPSPoint = GPSPoint(),
        maxLongitude: GPSPoint = GPSPoint()
}
