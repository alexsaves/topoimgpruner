//
//  AerialImageFileSetBounds.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/3/23.
//

import Foundation

struct AerialImageSetBounds {
    var minLatitude: GPSPoint = GPSPoint(),
        maxLatitude: GPSPoint = GPSPoint(),
        minLongitude: GPSPoint = GPSPoint(),
        maxLongitude: GPSPoint = GPSPoint()
}
