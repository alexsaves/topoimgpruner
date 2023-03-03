//
//  GPSInfo.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/3/23.
//

import Foundation

enum CompassPoint {
    case north
    case south
    case east
    case west
}

struct GPSInfo {
    var lat:Double = 0,
        long:Double = 0,
        altitude: Double = 0,
        latRef:CompassPoint = CompassPoint.north,
        longRef:CompassPoint = CompassPoint.west
}
