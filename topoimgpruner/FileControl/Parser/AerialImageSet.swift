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
            var gps:GPSInfo = img.gps
            print(img.url.absoluteString)
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
