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
    
    // Holds the Select image handler (called from map markers)
    private let _selectImgHandler: (AerialImage) -> Void
    
    // Holds the Select image handler (called from map markers)
    private let _toggleIncludedHandler: (AerialImage) -> Void
    
    /**
     * Sets up a new instance
     */
    init(forSet: AerialImageSet, selected: AerialImage, selectImage: @escaping (AerialImage) -> Void, includeToggle: @escaping (AerialImage) -> Void) {
        imgSet = forSet
        selectedItem = selected
        _selectImgHandler = selectImage
        _toggleIncludedHandler = includeToggle
    }
    
    /**
     * Renders the view
     */
    var body: some View {
            VStack(spacing: 10) {
                ForEach(imgSet.images) {img in
                    ImgThumbControl(img: img, selected: (selectedItem.id == img.id), isToggledOn: img.isIncludedInBatch, selectImage: _selectImgHandler, includeToggle: _toggleIncludedHandler)
                        .id(img.id)
                }
            }.frame(minWidth: 0, maxWidth: .infinity)
        
    }
}

struct ImgPicker_Previews: PreviewProvider {
    static var previews: some View {
        ImgPicker(forSet: AerialImageSet(), selected: AerialImage(), selectImage: { (information: AerialImage) -> Void in
            
        }, includeToggle: { (information: AerialImage) -> Void in
            
        })
    }
}
