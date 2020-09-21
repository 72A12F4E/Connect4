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
                let cellSize = scale / CGFloat(max(game.boardWidth, game.boardHeight))
                BoardView()
                    .frame(
                        width: cellSize * CGFloat(game.boardWidth),
                        height: cellSize * CGFloat(game.boardHeight),
                        alignment: .center
                    )
            }
            .navigationTitle("Connect \(game.winLength)")
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
        HStack {
            ForEach(0..<game.boardWidth) { column in
                // Since our model layer's representation of the game
                // board is 'rotated', we do some arithmetic here
                // to render the pieces in the correct spots
                let columnIndex = game.boardWidth - column - 1
                VStack {
                    ForEach(0..<game.boardHeight) { row in
                        ZStack {
                            Circle()
                                .strokeBorder(Color.black, lineWidth: 1)
                                .background(Circle().foregroundColor(Color.white))
                            let rowIndex = game.boardHeight - row - 1
                            if game.board.indices.contains(columnIndex),
                               game.board[columnIndex].indices.contains(rowIndex) {
                                let piece = game.board[columnIndex][rowIndex]
                                Circle()
                                    .strokeBorder(Color.black, lineWidth: 1)
                                    .background(Circle().foregroundColor(piece == .red ? Color.red : Color.black))
                            }
                        }
                    }
                }
                .onTapGesture(count: 1, perform: {
                    game.play(at: columnIndex)
                })
            }
        }
        .background(Color.yellow)
        .border(Color.black)
    }
}
