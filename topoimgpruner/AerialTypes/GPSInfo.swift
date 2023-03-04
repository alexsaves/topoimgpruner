//
//  GPSInfo.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/3/23.
//

import Foundation

/**
 * Holds basic drone GPS information
 */
struct GPSInfo {
    var lat:GPSPoint = GPSPoint(),
        long:GPSPoint = GPSPoint(),
        altitude: GPSPoint = GPSPoint()
}