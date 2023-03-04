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
    @State var hasError = false
    
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
        print("GOT IMGS")
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
