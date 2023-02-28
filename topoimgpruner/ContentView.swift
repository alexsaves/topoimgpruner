//
//  ContentView.swift
//  topoimgpruner
//
//  Created by Alexei White on 2/26/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack() {
            TopoFileSelector().frame(
                minWidth: 0,
                maxWidth: .infinity,
                alignment: .leading
            )
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
