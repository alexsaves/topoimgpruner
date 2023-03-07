//
//  ImgPicker.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/5/23.
//

import SwiftUI

struct ImgPicker: View {
    
    // Holds the image set
    @ObservedObject var imgSet: AerialImageSet
    
    // Holds the selected item
    @ObservedObject var selectedItem:AerialImage = AerialImage()
    
    /**
     * Sets up a new instance
     */
    init(forSet: AerialImageSet, selected: AerialImage) {
        imgSet = forSet
        selectedItem = selected
    }
    
    /**
     * Renders the view
     */
    var body: some View {
            VStack(spacing: 10) {
                ForEach(imgSet.images) {img in
                    ImgThumbControl(img: img, selected: (selectedItem.id == img.id))
                        .id(img.id)
                }
            }.frame(minWidth: 0, maxWidth: .infinity)
        
    }
}

struct ImgPicker_Previews: PreviewProvider {
    static var previews: some View {
        ImgPicker(forSet: AerialImageSet(), selected: AerialImage())
    }
}
