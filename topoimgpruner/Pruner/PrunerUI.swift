//
//  PrunerUI.swift
//  topoimgpruner
//
//  Created by Alexei White on 2/28/23.
//

import SwiftUI
import MapKit

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
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    struct PlaceAnnotationView: View {
      var body: some View {
        VStack(spacing: 0) {
          Image(systemName: "mappin.circle.fill")
            .font(.title)
            .foregroundColor(.red)
          
          Image(systemName: "arrowtriangle.down.fill")
            .font(.caption)
            .foregroundColor(.red)
            .offset(x: 0, y: -5)
        }
      }
    }
    
    // Render the view
    var body: some View {
        if (imgSet.images.count > 0) {
            HSplitView() {
                Map(
                    coordinateRegion: $region,
                    annotationItems: imgSet.images) { place in
                        MapAnnotation(coordinate: place.coordinate) {
                            PlaceAnnotationView()
                        }
                      }.layoutPriority(1)
                ScrollView(.vertical, showsIndicators: true) {
                    ImgPicker(forSet: imgSet)
                }
                .padding([.leading], 10)
                .frame(minWidth: 300, maxWidth: .infinity)
             }
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
