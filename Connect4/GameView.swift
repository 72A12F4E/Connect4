//
//  GameView.swift
//  Connect4
//
//  Created by Blake McAnally on 9/20/20.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject
    var game: Connect4
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                InfoView()
                Spacer()
                let scale = min(geometry.size.width, geometry.size.height)
                BoardView()
                    .frame(
                        width: scale,
                        height: scale,
                        alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/
                    )
            }
        }
    }
}

struct InfoView: View {
    @EnvironmentObject
    var game: Connect4
    
    var body: some View {
        VStack {
            if let winner = game.winner {
                let text = winner == .red ? "RED" : "BLACK"
                Text("Winner: \(text)")
                Button("Play Again?") {
                    game.reset()
                }
                Spacer()
            } else {
                if game.turn == .red {
                    Text("Red's Turn")
                } else {
                    Text("Black's Turn")
                }
            }
        }
    }
}

struct BoardView: View {
    @EnvironmentObject
    var game: Connect4
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<Algo.boardWidth) { column in
                    let columnIndex = Algo.boardWidth - column - 1
                    VStack {
                        ForEach(0..<Algo.boardHeight) { row in
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                                // Since our model layer's representation of the game
                                // board is 'rotated', we do some arithmetic here
                                // to render the pieces in the correct smots
                                let rowIndex = Algo.boardHeight - row - 1
                                if game.board.indices.contains(columnIndex),
                                   game.board[columnIndex].indices.contains(rowIndex) {
                                    let piece = game.board[columnIndex][rowIndex]
                                    Circle()
                                        .foregroundColor(piece == .red ? Color.red : Color.black)
                                }
                            }
                            
                        }
                    }
                    .onTapGesture(count: 1, perform: {
                        game.play(at: columnIndex)
                    })
                }
            }
            .padding()
        }
    }
}
