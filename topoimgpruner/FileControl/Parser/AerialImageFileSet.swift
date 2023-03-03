//
//  AerialImageFileSet.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/3/23.
//

import Foundation

class AerialImageFileSet {
    
    // The set of images
    var images: [AerialImageFile]
    
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
    init(images: [AerialImageFile]) {
        self.images = images
        calcBounds()
    }
}
