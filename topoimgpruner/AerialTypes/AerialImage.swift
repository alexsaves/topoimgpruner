//
//  AerialImageFile.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/1/23.
//

import Foundation
import CoreImage
import AppKit
import MapKit

/**
 * Describes a source aerial image file
 */
class AerialImage: ObservableObject, Identifiable {
    
    // Holds the identifiable ID
    var id: String {
        return url.absoluteString
    }
    
    // Image Pixel Width
    @Published var width:Int32 = 0
    
    // Image Pixel Height
    @Published var height:Int32 = 0
    
    // Source URL
    @Published var url:URL

    // EXIF Data
    @Published var exif:NSDictionary
    
    // Thumbnail
    @Published var thumb:NSImage
    
    // The GPS location information
    @Published var gps:GPSInfo = GPSInfo()
    
    // The name
    @Published var name:String
    
    // The MapKit friendly coordinate
    @Published var coordinate:CLLocationCoordinate2D
    
    /**
     * Convert an any value to a double
     */
    private func extractDoubleFromAny(val: Any?, defaultVal: Double) -> Double {
        var outVal = defaultVal
        let i = val as? Double
        if let unwrap = i {
            outVal = unwrap
        }
        return outVal
    }
    
    /**
     * Convert an any value to an int
     */
    private func extractInt32FromAny(val: Any?, defaultVal: Int32) -> Int32 {
        var outVal = defaultVal
        let i = val as? Int32
        if let unwrap = i {
            outVal = unwrap
        }
        return outVal
    }
    
    /**
     * Convert an any value to a String
     */
    private func extractStrFromAny(val: Any?, defaultVal: String) -> String {
        var outVal = defaultVal
        let i = val as? String
        if let unwrap = i {
            outVal = unwrap
        }
        return outVal
    }
    
    // Constructor
    init(fileUrl: URL, imageWidth: Int32, imageHeight: Int32, gpsInfo:NSDictionary, exifData:NSDictionary, thumbImg: CIImage) {
        url = fileUrl
        width = imageWidth
        height = imageHeight
        //gps = gpsInfo
        exif = exifData
        let rep: NSCIImageRep = NSCIImageRep(ciImage: thumbImg)
        let nsImage: NSImage = NSImage(size: rep.size)
        nsImage.addRepresentation(rep)
        thumb = nsImage
        name = fileUrl.lastPathComponent
        
        coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(0), longitude: CLLocationDegrees(0))
        
        let latitude:Double = extractDoubleFromAny(val: gpsInfo["Latitude"], defaultVal: 0)
        let longitude:Double = extractDoubleFromAny(val: gpsInfo["Longitude"], defaultVal: 0)
        coordinate.latitude = latitude
        coordinate.longitude = longitude
        
        // Do the GPS
        gps.lat.val = latitude
        gps.long.val = longitude
        gps.altitude.val = extractDoubleFromAny(val: gpsInfo["Altitude"], defaultVal: 0)
        gps.altitude.ref = CompassPoint.feet
        let latref = extractStrFromAny(val: gpsInfo["LatitudeRef"], defaultVal: "N")
        let longref = extractStrFromAny(val: gpsInfo["LongitudeRef"], defaultVal: "W")
        switch latref {
        case "N":
            gps.lat.ref = CompassPoint.north
        case "S":
            gps.lat.ref = CompassPoint.south
            gps.lat.val *= -1
        default:
            gps.lat.ref = CompassPoint.north
        }
        switch longref {
        case "W":
            gps.long.ref = CompassPoint.west
            gps.long.val *= -1
        case "E":
            gps.long.ref = CompassPoint.east
        default:
            gps.long.ref = CompassPoint.west
        }
    }
}
