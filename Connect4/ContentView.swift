//
//  ContentView.swift
//  Connect4
//
//  Created by Blake McAnally on 9/20/20.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var game: Connect4
    
    var body: some View {
        NavigationView {
            GameView()
        }.navigationTitle("Connect 4")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
