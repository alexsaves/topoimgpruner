//
//  PrunerUI.swift
//  topoimgpruner
//
//  Created by Alexei White on 2/28/23.
//

import SwiftUI

struct PrunerUI: View {
    var body: some View {
        VStack {
            HStack {
                Image("Logo").resizable()
                    .frame(width: 50.0, height: 50.0).opacity(0.3)
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity)
        .background(Color.init(red: 190, green: 190, blue: 255))
    }
}

struct PrunerUI_Previews: PreviewProvider {
    static var previews: some View {
        PrunerUI()
    }
}
