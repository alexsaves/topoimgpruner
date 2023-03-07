//
//  AerialImageFileSet.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/3/23.
//

import Foundation
import CoreLocation
import MapKit

class AerialImageSet: ObservableObject {
    
    // The set of images
    @Published var images: [AerialImage] = []
    
    // The boundaries
    @Published var bounds: AerialImageSetBounds
    
    // Specify the map region
    @Published var region: MKCoordinateRegion
    
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
        tmpbounds.mid.latitude = ((tmpbounds.max.latitude - tmpbounds.min.latitude) / 2) + tmpbounds.min.latitude
        tmpbounds.mid.longitude = ((tmpbounds.max.longitude - tmpbounds.min.longitude) / 2) + tmpbounds.min.longitude
        return tmpbounds
    }
    
    /**
     * Constructor
     */
    init(images: [AerialImage]) {
        self.images = images
        let tmpBounds:AerialImageSetBounds = AerialImageSet.calcBounds(images: images)
        self.bounds = AerialImageSetBounds(forMin: tmpBounds.min, forMax: tmpBounds.max, forMid: tmpBounds.mid)
        let latSpan:Double = max(abs(tmpBounds.max.latitude - tmpBounds.min.latitude) * 1.6, 0.005)
        let longSpan:Double = max(abs(tmpBounds.max.longitude - tmpBounds.min.longitude) * 1.6, 0.005)
        self.region = MKCoordinateRegion(center: tmpBounds.mid, span: MKCoordinateSpan(latitudeDelta: latSpan, longitudeDelta: longSpan))
    }
    
    init() {
        let tmpBounds:AerialImageSetBounds = AerialImageSet.calcBounds(images: [])
        self.bounds = AerialImageSetBounds(forMin: tmpBounds.min, forMax: tmpBounds.max, forMid: tmpBounds.mid)
        let latSpan:Double = max(abs(tmpBounds.max.latitude - tmpBounds.min.latitude) * 1.6, 0.005)
        let longSpan:Double = max(abs(tmpBounds.max.longitude - tmpBounds.min.longitude) * 1.6, 0.005)
        self.region = MKCoordinateRegion(center: tmpBounds.mid, span: MKCoordinateSpan(latitudeDelta: latSpan, longitudeDelta: longSpan))
    }
}
