//
//  DirParser.swift
//  topoimgpruner
//
//  Created by Alexei White on 2/28/23.
//

import Foundation

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
        //print("Scanning folder \(rootFolder)...")
        do {
            let url = URL(fileURLWithPath: rootFolder)
            if let enumerator = fm.enumerator(at: url, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) {
                for case let fileURL as URL in enumerator {
                    let fileAttributes = try fileURL.resourceValues(forKeys:[.isRegularFileKey])
                    if fileAttributes.isRegularFile! {
                        //print("Looking at regular file \(fileURL.path).")
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
        
        return _finalImageSet
    }
    
    /**
    * Start a parse operation
     */
    func parse() -> [AerialImageFile] {
        var _filesToCheck: [String] = crawlForFiles()
        if _filesToCheck.count == 0 {
            // Error on scan
            events.trigger(eventName: "error", information: "Found no eligible files to scan")
            return []
        } else {
            var _finalImageSet: [AerialImageFile] = filterValidAerialJPEGS(filesToCheck: _filesToCheck)
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
