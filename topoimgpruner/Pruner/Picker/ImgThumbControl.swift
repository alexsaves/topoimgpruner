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
    
    // Holds the Select image handler (called from map markers)
    private let _selectImgHandler: (AerialImage) -> Void
    
    /**
     * Constructor
     */
    init(img:AerialImage, selected:Bool, selectImage: @escaping (AerialImage) -> Void) {
        imgObj = img
        isSelected = selected
        _selectImgHandler = selectImage
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
        }
    }
}

struct ImgThumbControl_Previews: PreviewProvider {
    static var previews: some View {
        ImgThumbControl(img: AerialImage(), selected: false, selectImage: { (information: AerialImage) -> Void in
            
        })
    }
}
