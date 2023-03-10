//
//  ImgThumbControl.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/6/23.
//

import SwiftUI

struct ImgThumbControl: View {
    // Holds a reference to the root image object
    var imgObj:AerialImage
    
    // Is this visually selected?
    var isSelected:Bool
    
    // Is this toggled?
    var isToggled:Bool
    
    // Holds the Select image handler (called from map markers)
    private let _selectImgHandler: (AerialImage) -> Void
    
    // Holds the Select image handler (called from map markers)
    private let _toggleIncludedHandler: (AerialImage) -> Void
    
    /**
     * Constructor
     */
    init(img:AerialImage, selected:Bool, isToggledOn:Bool, selectImage: @escaping (AerialImage) -> Void, includeToggle: @escaping (AerialImage) -> Void) {
        imgObj = img
        isSelected = selected
        _selectImgHandler = selectImage
        _toggleIncludedHandler = includeToggle
        isToggled = isToggledOn
    }
    
    /**
     * Returns the view
     */
    var body: some View {
        ZStack {
            Image(nsImage: imgObj.thumb)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 200)
                .cornerRadius(5)
                .onTapGesture {
                    // Handle Selection
                    _selectImgHandler(imgObj)
                }
            if (isSelected) {
                Rectangle()
                    .fill(Color.yellow)
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 200)
                    .cornerRadius(5)
                    .opacity(0.2)
            }
                HStack {
                    ChooserButton(buttonImg: isToggled ? "bookmark.circle" : "circle")
                        .onTapGesture {
                            // Handle Selection
                            _selectImgHandler(imgObj)
                            
                            // Toggle whether or not its selected
                            _toggleIncludedHandler(imgObj)
                        }
                }.frame( maxWidth: .infinity,
                         maxHeight: .infinity,
                         alignment: .topTrailing )
        }
    }
}

struct ImgThumbControl_Previews: PreviewProvider {
    static var previews: some View {
        ImgThumbControl(img: AerialImage(), selected: false, isToggledOn: true, selectImage: { (information: AerialImage) -> Void in
            
        }, includeToggle: { (information: AerialImage) -> Void in
            
        })
    }
}
