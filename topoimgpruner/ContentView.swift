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
    
    /**
     * Master error handler
     */
    private func errorHandler(information:String) {
        hasError = true
        errorMessage = information
        print("Master error handler")
        print(information)
    }
    
    /**
     * Receives the image set
     */
    private func imgSetReadyHandler(imgSet:AerialImageSet) {
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
                print("GOT IMGS \(GMAPS_API_KEY)")
            }
        }        
    }
    
    /**
     * Constructor
     */
    init() {
        
    }
    
    var body: some View {
        VStack() {
            TopoFileSelector(errorHandler: errorHandler, imgSetReadyHandler: imgSetReadyHandler).frame(
                minWidth: 0,
                maxWidth: .infinity,
                alignment: .leading
            )
            if hasError {
                Text("Err: \(errorMessage)").foregroundColor(Color.red).frame(maxWidth: .infinity)
            } else {
                PrunerUI().frame(maxWidth: .infinity)
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
