//
//  ContentView.swift
//  topoimgpruner
//
//  Created by Alexei White on 2/26/23.
//

import SwiftUI

struct ContentView: View {
    
    // The folder name that has been set
    @State var errorMessage : String = ""
    
    // Whether we are ready to parse
    @State var hasError: Bool = false
    
    // The Google Maps API Key
    @State var GMAPS_API_KEY: String = ""
    
    // The set of images
    @StateObject var imgSet:AerialImageSet = AerialImageSet()
    
    // Holds a pubsub mechanism
    let events:EventHandler = EventHandler()
    
    /**
     * Master error handler
     */
    private func errorHandler(information:String) {
        hasError = true
        errorMessage = information
    }
    
    /**
     * Receives the image set
     */
    private func imgSetReadyHandler(imgSetObj:AerialImageSet) {
        let file = "mapsapi.txt"

        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

            let fileURL:URL = dir.appendingPathComponent(file)

            do {
                GMAPS_API_KEY = try String(contentsOf: fileURL, encoding: .utf8)
            }
            catch {
                
            }
            if GMAPS_API_KEY.count == 0 {
                hasError = true
                errorMessage = NSLocalizedString("missingMapsAPIKey", comment: "The window title") + "\(fileURL.absoluteString)"
            } else {
                imgSet.region = imgSetObj.region
                imgSet.images = imgSetObj.images
                imgSet.bounds = imgSetObj.bounds
            }
        }        
    }
    
    /**
     * Constructor
     */
    init() {
    }
    
    /**
     * Render the UI
     */
    var body: some View {
        VStack() {
            TopoFileSelector(
                errorHandler: errorHandler,
                imgSetReadyHandler: imgSetReadyHandler
            ).frame(
                minWidth: 0,
                maxWidth: .infinity,
                alignment: .leading
            )
            if hasError {
                Text("Err: \(errorMessage)").foregroundColor(Color.red).frame(maxWidth: .infinity)
            } else {
                PrunerUI(
                    events:events,
                    imgSetObj: imgSet
                ).frame(
                    maxWidth: .infinity
                )
            }
        }
        .padding()
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
