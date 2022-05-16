//
//  ConnectFourView.swift
//  TicTacToe (iOS)
//
//  Created by Matvey Garbuzov on 08.05.2022.
//

import SwiftUI

struct ConnectFourView: View {
    @EnvironmentObject var game: ConnectFourGameModel
    
    @State var gameOver: Bool = false
    @State var showSettingsView: Bool = false
    @State var showQuestionView: Bool = false
    @State private var angle: Double = 0
    
    func buttonAction(_ index : Int) {
        print("Index: \(index)")
        if game.squares[index].squareStatus == .empty {
            self.game.makeMove(index: index)
            self.gameOver = self.game.gameOver.1 // Check if there is a winner
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // GameScore
                ConnectFourTextInfo(settings: game.settings, score: game.score)
                // GameBoard
                ForEach(0 ..< game.settings.numberOfRows, content: { row in
                    HStack {
                        ForEach(0 ..< game.settings.numberOfColumns, content: { column in
                            let index = row * game.settings.numberOfColumns + column
                            ConnectFourSquareView(
                                dataSource: game.squares[index],
                                action: { self.buttonAction(index) },
                                size: UIScreen.main.bounds.size.width / 7 * 0.6,
                                settings: game.settings
                            )
                        })
                    }
                })
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
            )
            .background(Color.BG).ignoresSafeArea()
            .alert(isPresented: self.$gameOver, content: { gameOverAlert })
            .navigationBarItems(
                leading: HStack { settingsButton; resetGameButton },
                trailing: questionButton
            )
            // Sheets present settings and question views
        }.sheet(isPresented: $showSettingsView) {
            ConnectFourSettingsView(settings: game.settings)
        }.sheet(isPresented: $showQuestionView) {
            ConnectFourQuestionView()
        }
    }
    
    var gameOverAlert: Alert {
        Alert(
            title: Text("Game Over"),
            message: gameOverText,
            dismissButton: dismissButton
        )
    }
    
    var dismissButton: Alert.Button {
        Alert.Button.destructive(Text("Ok"), action: {
            game.addScore()
            game.resetGameBoard()
        })
    }
    
    var gameOverText: Text {
        return game.winnerText()
    }
    
    var settingsButton: some View {
        Button(action: {
            print("Settings button pressed.")
            self.showSettingsView.toggle()
        }) {
            Image(systemName: "gearshape.fill").imageScale(.large).foregroundColor(.main)
        }
    }
    
    var resetGameButton: some View {
        Button(action: {
            print("Reset button pressed.")
            game.score.resetScore()
            game.resetGameBoard()
            angle -= 360
        }) {
            Image(systemName: "gobackward").imageScale(.large).foregroundColor(.main)
        }.rotationEffect(.degrees(angle))
        .animation(.easeIn, value: angle)
    }
    
    var questionButton: some View {
        Button(action: {
            print("Questionmark button pressed.")
            self.showQuestionView.toggle()
        }) {
            Image(systemName: "questionmark.circle.fill").imageScale(.large).foregroundColor(.main)
        }
    }
}

// View showing game score and whose turn
struct ConnectFourTextInfo: View {
    @StateObject var settings: ConnectFourGameSettings
    @ObservedObject var score: ScoreModel
    @State private var angle: Double = 0.0
    
    var body: some View {
        HStack {
            // First player score
            HStack {
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(settings.firstPlayerColor)
                
                Text("Score: \(score.homeScore)")
                
            }.padding(.leading, 10)
            
            Spacer()
            
            // Arrow pointing on player that can make move
            Image(systemName: "arrow.left")
                .ArrowStyle(settings: settings)
            
            Spacer()
            
            // Second player score
            HStack {
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(settings.secondPlayerColor)
                
                Text("Score: \(score.visitorScore)")
            }.padding(.trailing, 10)
        }
        .frame(height: 45)
        .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.greyBG).opacity(0.75))
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

struct ConnectFourView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectFourView()
    }
}
