//
//  ImgThumbControl.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/6/23.
//

import SwiftUI

struct ImgThumbControl: View {
    var imgObj:AerialImage
    var isSelected:Bool
    init(img:AerialImage, selected:Bool) {
        imgObj = img
        isSelected = selected
    }
    var body: some View {
        ZStack {
            Image(nsImage: imgObj.thumb)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 200)
                .cornerRadius(5)
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
        ImgThumbControl(img: AerialImage(), selected: false)
    }
}
