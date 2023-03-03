//
//  TopoFileSelector.swift
//  topoimgpruner
//
//  Created by Alexei White on 2/26/23.
//

import SwiftUI
import Cocoa

struct TopoFileSelector: View {    
    // The default "no source set" string
    let noSourceStr = NSLocalizedString("chooseSourceDefault", comment: "Default text for choosing a source")
    
    // The folder name that has been set
    @State var folderName : String = ""
    
    // Whether we are ready to parse
    @State var parseReady = false
    
    // Are we in a parsing state?
    @State var isParsing = false
    
    // Messages the parse progress
    @State var parseProgress = NSLocalizedString("parseProgressInit", comment: "Default text for choosing a source")
    
    /*
     Launch the file selector
     */
    private func browseFiles() -> String {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.title = NSLocalizedString("chooseRootFolder", comment: "File picker root folder title")
        panel.message =  NSLocalizedString("chooseRootFolderLong", comment: "File picker root folder title long description")
        if panel.runModal() == .OK {
            return panel.url?.path ?? ""
        }
        return folderName
    }
    
    // Holds the error handler
    private let _errorHandler: (String) -> Void
    
    /**
     * Handle error emitted
     */
    private func emitError(information:Any?) {        
        if let info = information as? String {
            _errorHandler(info)
        }
    }
    
    private func handleProgress(information:Any?) {
        if let info = information as? String {
            parseProgress = info
        }
    }
    
    /**
     * Set up a new instance with an error handler
     */
    init(errorHandler: @escaping (String) -> Void) {
        _errorHandler = errorHandler
    }
    
    /*
     Holds main body
     */
    var body: some View {
        HStack {
            Button(NSLocalizedString("srcFolderButton", comment: "Choose a source folder button label")) {
                folderName = browseFiles()
                if folderName.count > 0 {
                    parseReady = true
                } else {
                    parseReady = false
                }
            }
            if isParsing {
                Text(parseProgress)
            } else {
                Text(folderName.count > 0 ? folderName : noSourceStr)
            }
            HStack {
                Button(NSLocalizedString("parseButton", comment: "Button for parsing a folder")) {
                    if parseReady {
                        isParsing = true
                        let parser = DirParser(root: folderName)
                        parser.events.subscribeTo(eventName: "error", action:emitError)
                        parser.events.subscribeTo(eventName: "progress", action:handleProgress)
                        parser.parse()
                    }
                }.disabled(!parseReady)
                Button(NSLocalizedString("exportButton", comment: "Button for exporting a project")) {}.disabled(true)
            }.frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

struct TopoFileSelector_Previews: PreviewProvider {
    static func errHandler(info:String) {}
    static var previews: some View {
        TopoFileSelector(errorHandler: errHandler)
    }
}
