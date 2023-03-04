//
//  AerialImageFileSet.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/3/23.
//

import Foundation

class AerialImageSet {
    
    // The set of images
    var images: [AerialImage]
    
    // The boundaries
    var bounds: AerialImageSetBounds
    
    /**
     * Determine boundaries
     */
    private func calcBounds() {
        for img in images {
            let gps:GPSInfo = img.gps
            if bounds.minLatitude.ref == CompassPoint.undefined {
                bounds.minLatitude.ref = gps.lat.ref
                bounds.minLatitude.val = gps.lat.val
            }
            if bounds.maxLatitude.ref == CompassPoint.undefined {
                bounds.maxLatitude.ref = gps.lat.ref
                bounds.maxLatitude.val = gps.lat.val
            }
            if bounds.minLongitude.ref == CompassPoint.undefined {
                bounds.minLongitude.ref = gps.long.ref
                bounds.minLongitude.val = gps.long.val
            }
            if bounds.maxLongitude.ref == CompassPoint.undefined {
                bounds.maxLongitude.ref = gps.long.ref
                bounds.maxLongitude.val = gps.long.val
            }
            if gps.lat.ref == CompassPoint.north && bounds.minLatitude.ref == CompassPoint.south {
                // The current lat was in southern hemisphere and the new one is in northern
                bounds.minLatitude.ref = gps.lat.ref
                bounds.minLatitude.val = gps.lat.val
            }
            if gps.lat.ref == bounds.minLatitude.ref && gps.lat.val > bounds.minLatitude.val {
                bounds.minLatitude.val = gps.lat.val
            }
            if gps.long.ref == CompassPoint.west && bounds.minLongitude.ref == CompassPoint.west {
                // The current lat was in Eastern hemisphere and the new one is in western
                bounds.minLongitude.ref = gps.long.ref
                bounds.minLongitude.val = gps.long.val
            }
            if gps.long.ref == bounds.minLongitude.ref && gps.long.val > bounds.minLongitude.val {
                bounds.minLongitude.val = gps.long.val
            }
            
            if gps.lat.ref == CompassPoint.south && bounds.maxLatitude.ref == CompassPoint.north {
                // The current lat was in northern hemisphere and the new one is in southern
                bounds.maxLatitude.ref = CompassPoint.south
                bounds.maxLatitude.val = gps.lat.val
            }
            if gps.lat.ref == bounds.maxLatitude.ref && gps.lat.val < bounds.maxLatitude.val {
                bounds.maxLatitude.val = gps.lat.val
            }
            if gps.long.ref == CompassPoint.east && bounds.maxLongitude.ref == CompassPoint.west {
                // The current lat was in northern hemisphere and the new one is in southern
                bounds.maxLongitude.ref = CompassPoint.east
                bounds.maxLongitude.val = gps.long.val
            }
            if gps.lat.ref == bounds.maxLongitude.ref && gps.long.val < bounds.maxLongitude.val {
                bounds.maxLongitude.val = gps.long.val
            }
        }
    }
    
    /**
     * Constructor
     */
    init(images: [AerialImage]) {
        self.images = images
        self.bounds = AerialImageSetBounds()
        calcBounds()
    }
}
