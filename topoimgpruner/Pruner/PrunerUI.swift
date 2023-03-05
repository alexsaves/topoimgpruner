//
//  PrunerUI.swift
//  topoimgpruner
//
//  Created by Alexei White on 2/28/23.
//

import SwiftUI

struct PrunerUI: View {
    
    // Holds the master window event handler
    var topEventHandler:EventHandler
    
    // Holds the image set
    @ObservedObject var imgSet:AerialImageSet = AerialImageSet()
    
    // Do we have the images?
    @State var hasImages:Bool = false
    
    /**
     * Constructor
     */
    init(events:EventHandler, imgSetObj: AerialImageSet) {
        self.topEventHandler = events
        imgSet.bounds = imgSetObj.bounds
        imgSet.images = imgSetObj.images
        if (imgSetObj.images.count > 0) {
            hasImages = true
        }
    }
    
    // Render the view
    var body: some View {
        if (imgSet.images.count > 0) {
            Text("Got images!")
        } else {
            VStack {
                HStack {
                    Image("Logo").resizable()
                        .frame(width: 50.0, height: 50.0).opacity(0.2)
                }
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity)
            .background(Color.init(red: 190, green: 190, blue: 255))
        }
    }
}

struct PrunerUI_Previews: PreviewProvider {
    static var previews: some View {
        PrunerUI(events: EventHandler(), imgSetObj: AerialImageSet())
    }
}
