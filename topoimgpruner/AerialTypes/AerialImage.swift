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
    @Published var altitude: Double
    
    // The name
    @Published var name:String
    
    // The MapKit friendly coordinate
    @Published var coordinate:CLLocationCoordinate2D
    
    // Constructor
    init(fileUrl: URL, imageWidth: Int32, imageHeight: Int32, gpsInfo:NSDictionary, exifData:NSDictionary, thumbImg: CIImage) {
        url = fileUrl
        width = imageWidth
        height = imageHeight
        exif = exifData
        let rep: NSCIImageRep = NSCIImageRep(ciImage: thumbImg)
        let nsImage: NSImage = NSImage(size: rep.size)
        nsImage.addRepresentation(rep)
        thumb = nsImage
        name = fileUrl.lastPathComponent
        
        var latitude:Double = 0
        let latTmp = gpsInfo["Latitude"] as? Double
        if let unwrapLat = latTmp {
            latitude = unwrapLat
        }
        var longitude:Double = 0
        let longTmp = gpsInfo["Longitude"] as? Double
        if let unwrapLong = longTmp {
            longitude = unwrapLong
        }
        var latref:String = "N"
        let latrefTmp = gpsInfo["LatitudeRef"] as? String
        if let unwrapLatRef = latrefTmp {
            latref = unwrapLatRef
        }
        var longref:String = "W"
        let longrefTmp = gpsInfo["LongitudeRef"] as? String
        if let unwrapLongRef = longrefTmp {
            longref = unwrapLongRef
        }
        switch latref {
            case "S":
                latitude *= -1
            default:
                break
        }
        switch longref {
            case "W":
                longitude *= -1
            default:
                break
        }
        
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        // Do altitude
        var _alt:Double = 0
        let longAlt = gpsInfo["Altitude"] as? Double
        if let unwrapAlt = longAlt {
            _alt = unwrapAlt
        }
        altitude = _alt
    }
}
