//
//  ImgPicker.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/5/23.
//

import SwiftUI

struct ImgPicker: View {
    
    // Holds the image set
    var imgSet: AerialImageSet
    
    /**
     * Sets up a new instance
     */
    init(forSet: AerialImageSet) {
        imgSet = forSet
    }
    
    var body: some View {
            VStack(spacing: 10) {
                ForEach(imgSet.images) {img in
                    Image(nsImage: img.thumb)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        //.scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 200)
                        .cornerRadius(5)
                }
            }.frame(minWidth: 0, maxWidth: .infinity)
        
    }
}

struct ImgPicker_Previews: PreviewProvider {
    static var previews: some View {
        ImgPicker(forSet: AerialImageSet())
    }
}
