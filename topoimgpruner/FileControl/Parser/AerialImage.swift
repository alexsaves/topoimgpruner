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
class AerialImage {
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
        gps.lat.val = extractDoubleFromAny(val: gpsInfo["Latitude"], defaultVal: 0)
        gps.long.val = extractDoubleFromAny(val: gpsInfo["Longitude"], defaultVal: 0)
        gps.altitude.val = extractDoubleFromAny(val: gpsInfo["Altitude"], defaultVal: 0)
        gps.altitude.ref = CompassPoint.feet
        let latref = extractStrFromAny(val: gpsInfo["LatitudeRef"], defaultVal: "N")
        let longref = extractStrFromAny(val: gpsInfo["LongitudeRef"], defaultVal: "W")
        switch latref {
        case "N":
            gps.lat.ref = CompassPoint.north
        case "S":
            gps.lat.ref = CompassPoint.south
        default:
            gps.lat.ref = CompassPoint.north
        }
        switch longref {
        case "W":
            gps.long.ref = CompassPoint.west
        case "E":
            gps.long.ref = CompassPoint.east
        default:
            gps.long.ref = CompassPoint.west
        }
    }
}
