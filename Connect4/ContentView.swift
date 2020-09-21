//
//  ContentView.swift
//  Connect4
//
//  Created by Blake McAnally on 9/20/20.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State var piecesToWin: Int = 4
    let piecesOptions = Array(3...8)
    
    @State var columns: Int = 7
    var columnOptions: [Int] {
        Array(piecesToWin...15)
    }
    
    @State var rows: Int = 6
    var rowOptions: [Int] {
        Array(piecesToWin...15)
    }
    
    private var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.allowsFloats = false
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Game Options")) {
                    Picker("Pieces To Win", selection: $piecesToWin) {
                        ForEach(piecesOptions, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    Picker("Columns", selection: $columns) {
                        ForEach(columnOptions, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    Picker("Rows", selection: $rows) {
                        ForEach(rowOptions, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                
                NavigationLink(
                    "Start Game",
                    destination: GameView().environmentObject(
                        Connect4(
                            width: columns,
                            height: rows,
                            winLength: piecesToWin
                        )
                    )
                )
            }.navigationTitle("Connect N")
        }
    }
}


