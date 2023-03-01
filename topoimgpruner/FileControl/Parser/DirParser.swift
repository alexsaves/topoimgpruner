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
    * Start a parse operation
     */
    func parse() {
        var _foldersToCrawl: [String] = []
        _foldersToCrawl.append(rootFolder)
        
        
            // Iterate over the folders
            while _foldersToCrawl.count > 0 {
                let _folder: String = _foldersToCrawl.popLast()!
                let fm = FileManager.default
                do {
                    let items = try fm.contentsOfDirectory(atPath: _folder)
                    for item in items {
                        print("Found \(item)")
                    }
                } catch {
                    // Error on file IO
                    events.trigger(eventName: "error", information: "IO Error on parser")
                    break;
                }
                
            }
        
    }
}
