//
//  Connect4.swift
//  Connect4
//
//  Created by Blake McAnally on 9/20/20.
//

// Game Engine
import SwiftUI

enum Piece {
    case black
    case red
}

extension Piece: Identifiable {
    var id: String {
        debugDescription
    }
}

extension Piece: CustomDebugStringConvertible {
    var debugDescription: String {
        self == .red ? "RED" : "BLACK"
    }
}

class Connect4: ObservableObject {
    
    public let boardWidth: Int
    public let boardHeight: Int
    public let winLength: Int
    
    @Published
    public private(set) var board: [[Piece?]]
    
    @Published
    public private(set) var winner: Piece?
    
    @Published
    public private(set) var turn: Piece = .red
    
    init(
        width: Int = 7,
        height: Int = 6,
        winLength: Int = 4
    ) {
        self.boardWidth = width
        self.boardHeight = height
        self.winLength = winLength
        board = Array(repeating: [], count: boardWidth)
        winner = nil
        turn = .red
    }
    
    func play(at column: Int) {
        guard winner == nil,
              board.indices.contains(column),
              board[column].count < boardHeight else { return }
        
        board[column].append(turn)
        if let p = checkWinner(board) {
            winner = p
        } else {
            turn = turn == .red ? .black : .red
        }
    }
    
    func reset() {
        board = Array(repeating: [], count: boardWidth)
        winner = nil
        turn = .red
    }
    
    func checkWinner(_ board: [[Piece?]]) -> Piece? {
        //check columns
        for column in board where column.count >= winLength {
            for offset in 0...column.count - winLength {
                if column[offset..<offset + winLength].allSatisfy({ column[offset] == $0 }) {
                    return column[offset]
                }
            }
        }

        //check rows
        for columnOffset in 0...boardWidth - winLength {
            nextWindow: for rowOffset in 0...boardHeight - winLength {
                var window: [Piece] = []
                for i in 0...boardWidth - winLength {
                    guard board.indices.contains(columnOffset + i),
                          board[columnOffset + i].indices.contains(rowOffset) else { break nextWindow }
                    guard let piece = board[columnOffset + i][rowOffset] else { break nextWindow }
                    window.append(piece)
                }
                if window.allSatisfy({ window.first == $0 }) {
                    return window.first
                }
            }
        }

        //check left diagonals
        for columnOffset in 0..<boardWidth where columnOffset + winLength <= boardWidth {
            nextWindow: for rowOffset in 0..<boardHeight where rowOffset + winLength <= boardHeight {
                var window: [Piece] = []
                for i in 0..<winLength {
                    guard board.indices.contains(columnOffset + i),
                          board[columnOffset + i].indices.contains(rowOffset + i) else {
                        break nextWindow
                    }
                    guard let piece = board[columnOffset + i][rowOffset + i] else { break nextWindow }
                    window.append(piece)
                }

                if window.allSatisfy({ window.first == $0 }) {
                    return window.first
                }
            }
        }
        
        //check right diagonals
        for columnOffset in boardWidth - winLength..<boardWidth {
            nextWindow: for rowOffset in 0...boardHeight - winLength {
                var window: [Piece] = []
                for i in 0..<winLength {
                    guard board.indices.contains(columnOffset - i),
                          board[columnOffset - i].indices.contains(rowOffset + i) else {
                        break nextWindow
                    }

                    guard let piece = board[columnOffset - i][rowOffset + i] else { break nextWindow }
                    window.append(piece)
                }

                if window.allSatisfy({ window.first == $0 }) {
                    return window.first
                }
            }
        }
        
        return nil
    }
}
