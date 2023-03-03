//
//  AerialImageFile.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/1/23.
//

import Foundation
import CoreImage

/**
 * Describes a source aerial image file
 */
class AerialImageFile {
    // Image Pixel Width
    var width:Int32 = 0
    
    // Image Pixel Height
    var height:Int32 = 0
    
    // Source URL
    var url:URL

    // EXIF Data
    var exif:NSDictionary
    
    // Thumbnail
    var thumb:CIImage
    
    // The GPS location information
    var gps:GPSInfo = GPSInfo()
    
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
    init(fileUrl: String, imageWidth: Int32, imageHeight: Int32, gpsInfo:NSDictionary, exifData:NSDictionary, thumbImg: CIImage) {
        url = URL(fileURLWithPath: fileUrl)
        width = imageWidth
        height = imageHeight
        //gps = gpsInfo
        exif = exifData
        thumb = thumbImg
        
        // Do the GPS
        gps.lat = extractDoubleFromAny(val: gpsInfo["Latitude"], defaultVal: 0)
        gps.long = extractDoubleFromAny(val: gpsInfo["Longitude"], defaultVal: 0)
        gps.altitude = extractDoubleFromAny(val: gpsInfo["Altitude"], defaultVal: 0)
        let latref = extractStrFromAny(val: gpsInfo["LatitudeRef"], defaultVal: "N")
        let longref = extractStrFromAny(val: gpsInfo["LongitudeRef"], defaultVal: "W")
        switch latref {
        case "N":
            gps.latRef = CompassPoint.north
        case "S":
            gps.latRef = CompassPoint.south
        default:
            gps.latRef = CompassPoint.north
        }
        switch longref {
        case "W":
            gps.longRef = CompassPoint.west
        case "E":
            gps.longRef = CompassPoint.east
        default:
            gps.longRef = CompassPoint.west
        }
    }
}
