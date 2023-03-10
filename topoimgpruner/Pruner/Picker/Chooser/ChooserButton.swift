//
//  ChooserButton.swift
//  topoimgpruner
//
//  Created by Alexei White on 3/9/23.
//

import SwiftUI

struct ChooserButton: View {
    
    /**
     * Set up the button image
     */
    let btnImg: String
    
    /**
     * The size of the button
     */
    let buttonSize:CGFloat = 40
    
    /**
     * Set up the new button
     */
    init(buttonImg:String) {
        btnImg = buttonImg
    }
    
    /**
     * Render the view
     */
    var body: some View {
        ZStack {
            Rectangle().fill(Color.white).cornerRadius(3).frame(width: buttonSize, height:buttonSize)
            Image(systemName: btnImg)
                .font(.system(size: buttonSize-7))
                .foregroundColor(Color.blue)
                .frame(width: buttonSize, height:buttonSize)
        }.padding()
    }
}

struct ChooserButton_Previews: PreviewProvider {
    static var previews: some View {
        ChooserButton(buttonImg: "bookmark.circle")
    }
}
