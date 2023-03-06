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
    
    var body: some View {
            VStack(spacing: 10) {
                ForEach(imgSet.images) {img in
                    if (selectedItem.id == img.id) {
                        Image(nsImage: img.thumb)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 200)
                            .border(.green)
                            .cornerRadius(5)
                    } else {
                        Image(nsImage: img.thumb)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 200)
                            .border(.red)
                            .cornerRadius(5)
                            
                    }
                }
            }.frame(minWidth: 0, maxWidth: .infinity)
        
    }
}

struct ImgPicker_Previews: PreviewProvider {
    static var previews: some View {
        ImgPicker(forSet: AerialImageSet(), selected: AerialImage())
    }
}
