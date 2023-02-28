//
//  TopoFileSelector.swift
//  topoimgpruner
//
//  Created by Alexei White on 2/26/23.
//

import SwiftUI
import Cocoa

struct TopoFileSelector: View {
    
    let noSourceStr = "[Choose a source]"
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
        panel.title = "Choose a root folder"
        panel.message = "Choose a folder to crawl for images"
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
            Button("Src Folder") {
                folderName = browseFiles()
                if folderName.count > 0 {
                    parseReady = true
                } else {
                    parseReady = false
                }
            }
            Text(folderName.count > 0 ? folderName : noSourceStr)
            HStack {
                Button("Parse") {}.disabled(!parseReady)
                Button("Export to…") {}.disabled(true)
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
