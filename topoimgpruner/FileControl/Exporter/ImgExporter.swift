//
//  ImgExporter.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/12/23.
//

import Foundation

/**
 * Exports final image set to disk
 */
class ImgExporter {
    // Holds the image set to export
    let imgSet:AerialImageSet
    
    /**
     * Initialize with images
     */
    init(imgset:AerialImageSet) {
        imgSet = imgset
    }
    
    /**
     * Make the aerial image file name
     */
    private func generateDestinationImageFilename(img:AerialImage) -> String {
        var finalStr:String = "loc_"
        finalStr += "\(img.coordinate.latitude)".replacingOccurrences(of: ".", with: "_")
        finalStr += "__"
        finalStr += "\(img.coordinate.longitude)".replacingOccurrences(of: ".", with: "_")
        finalStr += "__"
        finalStr += "\(img.altitude)".replacingOccurrences(of: ".", with: "_")
        finalStr += ".jpg"
        return finalStr
    }
    
    /**
     * Export the images
     */
    func export(destination:String) {
        
        for img in imgSet.images
        {
            if (img.isIncludedInBatch) {
                let fileStr:String = generateDestinationImageFilename(img: img)
                let finalDestLocationStr:String = "\(destination)/\(fileStr)"
                //let finalDestURL:URL = URL(fileURLWithPath:finalDestLocationStr)
                let finalDestURL:URL = URL(fileURLWithPath:"\(destination)/out.jpg")
                do {
                    // Get the saved data
                    let savedData = try Data(contentsOf: img.url)
                    
                    // Write
                    try savedData.write(to: finalDestURL)
                    
                    print("File saved: \(finalDestURL.absoluteURL)")
                } catch {
                     // Catch any errors
                     print("Unable to read the file")
                }
            }
        }
    }
}
