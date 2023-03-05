//
//  AerialImageFileSet.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/3/23.
//

import Foundation
import CoreLocation

class AerialImageSet: ObservableObject {
    
    // The set of images
    @Published var images: [AerialImage] = []
    
    // The boundaries
    @Published var bounds: AerialImageSetBounds
    
    /**
     * Determine boundaries
     */
    static func calcBounds(images: [AerialImage]) -> AerialImageSetBounds {
        var tmpbounds:AerialImageSetBounds = AerialImageSetBounds(forMin: CLLocationCoordinate2D(latitude: 0,longitude: 0), forMax: CLLocationCoordinate2D(latitude: 0,longitude: 0), forMid: CLLocationCoordinate2D(latitude: 0,longitude: 0))
        
        var isFirst: Bool = true
        
        // Calculate the outer boundaries of the image set
        for img in images {
            if isFirst || img.coordinate.latitude < tmpbounds.min.latitude {
                tmpbounds.min.latitude = img.coordinate.latitude
            }
            if isFirst || img.coordinate.longitude < tmpbounds.min.longitude {
                tmpbounds.min.longitude = img.coordinate.longitude
            }
            if isFirst || img.coordinate.latitude > tmpbounds.max.latitude {
                tmpbounds.max.latitude = img.coordinate.latitude
            }
            if isFirst || img.coordinate.longitude > tmpbounds.max.longitude {
                tmpbounds.max.longitude = img.coordinate.longitude
            }
            isFirst = false
        }
        
        tmpbounds.mid.latitude = (tmpbounds.mid.latitude + tmpbounds.max.latitude) / 2
        tmpbounds.mid.longitude = (tmpbounds.mid.longitude + tmpbounds.max.longitude) / 2
        return tmpbounds
    }
    
    /**
     * Constructor
     */
    init(images: [AerialImage]) {
        self.images = images
        let tmpBounds:AerialImageSetBounds = AerialImageSet.calcBounds(images: images)
        self.bounds = AerialImageSetBounds(forMin: tmpBounds.min, forMax: tmpBounds.max, forMid: tmpBounds.mid)
    }
    
    init() {
        let tmpBounds:AerialImageSetBounds = AerialImageSet.calcBounds(images: [])
        self.bounds = AerialImageSetBounds(forMin: tmpBounds.min, forMax: tmpBounds.max, forMid: tmpBounds.mid)
    }
}
