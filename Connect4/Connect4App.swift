//
//  Connect4App.swift
//  Connect4
//
//  Created by Blake McAnally on 9/20/20.
//

import SwiftUI

@main
struct Connect4App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Connect4())
        }
    }
}
