//
//  AerialImageFileSet.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/3/23.
//

import Foundation

class AerialImageSet: ObservableObject {
    
    // The set of images
    @Published var images: [AerialImage] = []
    
    // The boundaries
    @Published var bounds: AerialImageSetBounds
    
    /**
     * Determine boundaries
     */
    private func calcBounds() -> AerialImageSetBounds {
        // Calculate the outer boundaries of the image set
        for img in images {
            if bounds.min.latitude.ref == CompassPoint.undefined {
                bounds.min.latitude.ref = gps.lat.ref
                bounds.min.latitude.val = gps.lat.val
            }
            if bounds.maxLatitude.ref == CompassPoint.undefined {
                bounds.maxLatitude.ref = gps.lat.ref
                bounds.maxLatitude.val = gps.lat.val
            }
            if bounds.min.longitude.ref == CompassPoint.undefined {
                bounds.min.longitude.ref = gps.long.ref
                bounds.min.longitude.val = gps.long.val
            }
            if bounds.maxLongitude.ref == CompassPoint.undefined {
                bounds.maxLongitude.ref = gps.long.ref
                bounds.maxLongitude.val = gps.long.val
            }
            if gps.lat.ref == CompassPoint.north && bounds.min.latitude.ref == CompassPoint.south {
                // The current lat was in southern hemisphere and the new one is in northern
                bounds.min.latitude.ref = gps.lat.ref
                bounds.min.latitude.val = gps.lat.val
            }
            if gps.lat.ref == bounds.min.latitude.ref && gps.lat.val > bounds.min.latitude.val {
                bounds.min.latitude.val = gps.lat.val
            }
            if gps.long.ref == CompassPoint.west && bounds.min.longitude.ref == CompassPoint.west {
                // The current lat was in Eastern hemisphere and the new one is in western
                bounds.min.longitude.ref = gps.long.ref
                bounds.min.longitude.val = gps.long.val
            }
            if gps.long.ref == bounds.min.longitude.ref && gps.long.val > bounds.min.longitude.val {
                bounds.min.longitude.val = gps.long.val
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
        
        // Now calculate the midpoint of the boundary
        if bounds.min.latitude.ref == bounds.maxLatitude.ref {
            // they are in the same hemisphere, this should be easy
            
            bounds.midLatitude.ref = bounds.min.latitude.ref
        } else {
            // TODO: figure out cross-hemisphere midpoints
        }
        
        if bounds.min.longitude.ref == bounds.maxLongitude.ref {
            // they are in the same hemisphere, this should be easy
            bounds.midLongitude.ref = bounds.min.latitude.ref
        } else {
            // TODO: figure out cross-hemisphere midpoints
        }
        
        bounds.midLatitude.val = (bounds.min.latitude.val + bounds.maxLatitude.val) / 2
        bounds.midLongitude.val = (bounds.min.longitude.val + bounds.maxLongitude.val) / 2
        
        // Finally, Calculate the zoom level
        bounds.zoom = 15;
    }
    
    /**
     * Constructor
     */
    init(images: [AerialImage]) {
        self.images = images
        self.bounds = AerialImageSetBounds()
        calcBounds()
    }
    
    init() {}
}
