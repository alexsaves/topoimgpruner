//
//  AerialImageFile.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/1/23.
//

import Foundation

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
    
    // Constructor
    init(fileUrl: String, imageWidth: Int32, imageHeight: Int32) {
        url = URL(fileURLWithPath: fileUrl)
        width = imageWidth
        height = imageHeight
    }
}
