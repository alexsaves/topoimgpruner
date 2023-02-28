//
//  TopoFileSelector.swift
//  topoimgpruner
//
//  Created by Alexei White on 2/26/23.
//

import SwiftUI
import Cocoa

struct TopoFileSelector: View {
    
    let noSourceStr = NSLocalizedString("chooseSourceDefault", comment: "Default text for choosing a source")
    @State var folderName : String = ""
    @State var parseReady = false
    
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
            return panel.url?.absoluteString ?? ""
        }
        return folderName
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
            Text(folderName.count > 0 ? folderName : noSourceStr)
            HStack {
                Button(NSLocalizedString("parseButton", comment: "Button for parsing a folder")) {}.disabled(!parseReady)
                Button(NSLocalizedString("exportButton", comment: "Button for exporting a project")) {}.disabled(true)
            }.frame(maxWidth: .infinity, alignment: .trailing)
        }
        .border(Color.pink)
    }
}

struct TopoFileSelector_Previews: PreviewProvider {
    static var previews: some View {
        TopoFileSelector()
    }
}
