//
//  GPSPoint.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/3/23.
//

import Foundation

/**
 * Defines a specific point in GPS 3D space
 */
struct GPSPoint {
    var val:Double = 0,
        ref:CompassPoint = CompassPoint.undefined
}
