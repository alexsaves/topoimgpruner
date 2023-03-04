//
//  DirParser.swift
//  topoimgpruner
//
//  Created by Alexei White on 2/28/23.
//

import Foundation
import CoreImage

class DirParser {
    
    // Holds a pubsub mechanism
    let events = EventHandler();
    
    // Keeps track of which file we've parsed
    private var _parseIndex:Int = 0
    
    // The root of the parser
    public var rootFolder: String = ""
    
    // Holds the final output set of images
    private var _finalImageSet: [AerialImage] = []
    
    // Holds the files we need to check
    private var _filesToCheck: [URL] = []
    
    /**
     * Set up a new instance of the parser
     */
    init(root: String) {
        self.rootFolder = root
    }
    
    /**
     * Get the list of possible files first
     */
    private func crawlForFiles() -> [URL] {
        var _filesToCheck: [URL] = []
        let fm = FileManager.default
        do {
            let url = URL(fileURLWithPath: rootFolder)
            if let enumerator = fm.enumerator(at: url, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) {
                for case let fileURL as URL in enumerator {
                    let fileAttributes = try fileURL.resourceValues(forKeys:[.isRegularFileKey])
                    if fileAttributes.isRegularFile! {
                        if fileURL.pathExtension.uppercased() == "JPG" {
                            _filesToCheck.append(fileURL)
                        }
                    }
                }
            }
            
        } catch {
            // Error on file IO
            events.trigger(eventName: "error", information: "IO Error on parser")
        }
        return _filesToCheck
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
     * Convert an any value to a hashmap
     */
    private func extractDictFromAny(val: Any?) -> NSDictionary {
        var outVal: NSDictionary = NSDictionary()
        let i = val as? NSDictionary
        if let unwrap = i {
            outVal = unwrap
        }
        return outVal
    }
    
    /**
     * Convert an any value to an Array
     */
    private func extractArrFromAny(val: Any?) -> NSArray {
        var outVal: NSArray = NSArray()
        let i = val as? NSArray
        if let unwrap = i {
            outVal = unwrap
        }
        return outVal
    }
    
    /**
     * Generate a thumbnail
     */
    private func getThumbnail(sourceImage: CIImage) -> CIImage {
        let resizeFilter = CIFilter(name:"CILanczosScaleTransform")!

        // Desired output size
        let targetSize = NSSize(width:500, height:500)

        // Compute scale and corrective aspect ratio
        let scale = targetSize.height / (sourceImage.extent.height)
        let aspectRatio = targetSize.width/((sourceImage.extent.width) * scale)

        // Apply resizing
        resizeFilter.setValue(sourceImage, forKey: kCIInputImageKey)
        resizeFilter.setValue(scale, forKey: kCIInputScaleKey)
        resizeFilter.setValue(aspectRatio, forKey: kCIInputAspectRatioKey)
        var outputImage = CIImage()
        if let unwrap = resizeFilter.outputImage {
            outputImage = unwrap
        }
        return outputImage
    }
    
    /**
     * Produce a finished list of jpegs
     */
    @objc func filterNextValidAerialJPEG() {
        let imgSrcUrl = _filesToCheck[_parseIndex]
        if let ciImage = CIImage(contentsOf: imgSrcUrl) {
            let props:[String: Any] = ciImage.properties,
                imgW:Int32 = extractInt32FromAny(val: props["PixelWidth"], defaultVal: 0),
                imgH:Int32 = extractInt32FromAny(val: props["PixelHeight"], defaultVal: 0),
                GPSInfo:NSDictionary = extractDictFromAny(val: props["{GPS}"]),
                EXIF:NSDictionary = extractDictFromAny(val: props["{Exif}"])
            
            let aImg = AerialImage(fileUrl: imgSrcUrl, imageWidth: imgW, imageHeight: imgH, gpsInfo: GPSInfo, exifData: EXIF, thumbImg: getThumbnail(sourceImage: ciImage))
            
            _finalImageSet.append(aImg)
        }
        
        _setAdvanceToNextFile()
    }
    
    private func _setAdvanceToNextFile() {
        _parseIndex += 1
        if (_parseIndex < _filesToCheck.count) {
            let parseMsg = NSLocalizedString("parseProgress", comment: "Default text for choosing a source")
            let url = _filesToCheck[_parseIndex]
            events.trigger(eventName: "progress", information: "\(parseMsg) (\(_parseIndex+1)/\(_filesToCheck.count)) '\(url.lastPathComponent)'")
            Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(filterNextValidAerialJPEG), userInfo: nil, repeats: false)
        } else {
            // Done!
            let _finalAerialSet: AerialImageSet = AerialImageSet(images: _finalImageSet)
            if _filesToCheck.count == 0 {
                // Error on scan
                events.trigger(eventName: "error", information: "Found no eligible aerial images from scan")
            } else {
                events.trigger(eventName: "parseDone", information: _finalAerialSet)
            }
        }
    }
    
    /**
    * Start a parse operation
     */
    func parse() {
        _filesToCheck = crawlForFiles()
        if _filesToCheck.count == 0 {
            // Error on scan
            events.trigger(eventName: "error", information: "Found no eligible files to scan")
        } else {
            // Reset the parse index
            _parseIndex = -1
            _setAdvanceToNextFile()
        }
    }
}
