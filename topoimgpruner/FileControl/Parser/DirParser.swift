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
    
    // The root of the parser
    public var rootFolder: String = ""
    
    /**
     * Set up a new instance of the parser
     */
    init(root: String) {
        self.rootFolder = root
    }
    
    /**
     * Get the list of possible files first
     */
    private func crawlForFiles() -> [String] {
        var _filesToCheck: [String] = []
        let fm = FileManager.default
        do {
            let url = URL(fileURLWithPath: rootFolder)
            if let enumerator = fm.enumerator(at: url, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) {
                for case let fileURL as URL in enumerator {
                    let fileAttributes = try fileURL.resourceValues(forKeys:[.isRegularFileKey])
                    if fileAttributes.isRegularFile! {
                        if !_filesToCheck.contains(fileURL.path) {
                            _filesToCheck.append(fileURL.path)
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
     * Produce a finished list of jpegs
     */
    private func filterValidAerialJPEGS(filesToCheck: [String]) -> [AerialImageFile] {
        var _finalImageSet: [AerialImageFile] = []
        let countOfImgs = filesToCheck.count;
        var progressCounter = 0;
        let parseMsg = NSLocalizedString("parseProgress", comment: "Default text for choosing a source")
        for imgSrcUrl in filesToCheck {
            progressCounter += 1
            let url = URL(fileURLWithPath: imgSrcUrl)
            if (url.pathExtension.uppercased() == "JPG") {
                events.trigger(eventName: "progress", information: "\(parseMsg) \(progressCounter)/\(countOfImgs) '\(imgSrcUrl)'")
                //let context = CIContext()
                let ciImage = CIImage(contentsOf: url)
                if (ciImage != nil) {
                    let props:[String: Any] = ciImage!.properties
                    var imgW:Int32 = 0,
                        imgH:Int32 = 0,
                        orientation:Int32  = 0
                    
                    var i = props["PixelWidth"] as? Int32
                    if let unwrap = i {
                        imgW = unwrap
                    }
                    
                    i = props["PixelHeight"] as? Int32
                    if let unwrap = i {
                        imgH = unwrap
                    }
                    
                    i = props["Orientation"] as? Int32
                    if let unwrap = i {
                        orientation = unwrap
                    }
// FIGURE OUT ANGLE IF ITS VALID
                    let aImg = AerialImageFile(fileUrl: imgSrcUrl, imageWidth: imgW, imageHeight: imgH)
                    print(props.count)
                    _finalImageSet.append(aImg)
                }
            }

            
            
            print(imgSrcUrl);
        }
        return _finalImageSet
    }
    
    /**
    * Start a parse operation
     */
    func parse() -> [AerialImageFile] {
        let _filesToCheck: [String] = crawlForFiles()
        if _filesToCheck.count == 0 {
            // Error on scan
            events.trigger(eventName: "error", information: "Found no eligible files to scan")
            return []
        } else {
            let _finalImageSet: [AerialImageFile] = filterValidAerialJPEGS(filesToCheck: _filesToCheck)
            if _filesToCheck.count == 0 {
                // Error on scan
                events.trigger(eventName: "error", information: "Found no eligible aerial images from scan")
                return []
            } else {
                return _finalImageSet
            }
        }
    }
}
