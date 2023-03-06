//
//  PickerItem.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/5/23.
//

import SwiftUI

struct PickerItem: View {
    // Is this item selected?
    @State var isSelected:Bool
    
    // Holds the image
    @State var img:AerialImage
    
    // Constructor
    init(forImg: AerialImage, selected:Bool) {
        isSelected = selected
        img = forImg
    }
    
    // Holds the view
    var body: some View {
        Image(nsImage: img.thumb)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 200)
            .cornerRadius(5)
    }
}

struct PickerItem_Previews: PreviewProvider {
    static var previews: some View {
        PickerItem(forImg: AerialImage(), selected: false)
    }
}
