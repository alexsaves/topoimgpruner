//
//  MapsImageFileGrabber.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/4/23.
//

import Foundation
import CoreImage

/**
 * Grabs Gmaps Images
 */
class MapsImageFileGrabber {
    // The GCP API Key for the static maps API
    var API_KEY:String = ""
    
    /**
     * Sets up a new instance
     */
    init(apiKey: String) {
        API_KEY = apiKey
    }
    
    /**
     * Retrieve an image from the static api
     */
    func grabMapsImage(forSet: AerialImageSet) -> CIImage {
        var imgURLStr:String = "https://maps.googleapis.com/maps/api/staticmap?"
        imgURLStr += "center=\(forSet.bounds.midLatitude.val),\(forSet.bounds.midLongitude.val)"
        imgURLStr += "&zoom=\(forSet.bounds.zoom)"
        imgURLStr += "&size=1000x1000"
        imgURLStr += "&maptype=hybrid"
        imgURLStr += "&key=\(API_KEY)"
        
        let data = try? Data(contentsOf: URL(string: imgURLStr)!)
        if let ciImage = CIImage(data: data!) {
            print(ciImage.url?.absoluteString ?? "no image")
            return ciImage
        }
        
        return CIImage()
    }
}
