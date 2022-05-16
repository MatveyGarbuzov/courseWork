//
//  BoardView.swift
//  TicTacToe (iOS)
//
//  Created by Matvey Garbuzov on 06.05.2022.
//

import SwiftUI

struct MinesweeperView: View {
    @EnvironmentObject var game: MinesweeperGameModel
    
    @State var showSettingsView: Bool = false
    @State var showQuestionView: Bool = false
    @State private var angle: Double = 0

    var body: some View {
        NavigationView {
            VStack {
                MinesweeperTextInfo(gameSettings: game.settings)
                VStack(spacing: game.settings.spacing) {
                    ForEach(0..<game.board.count, id: \.self) { row in
                        HStack(spacing: game.settings.spacing) {
                            ForEach(0..<game.board[row].count, id: \.self) { col in
                                MinesweeperSquareView(cell: game.board[row][col])
                            }
                        }
                    }
                }.alert(isPresented: $game.showResult) {
                    Alert(title: Text(game.isWon ? "Wow" : "Oh no!"),
                          message: Text(game.isWon ? "You won the match" :"Better luck next time"),
                          dismissButton: .destructive(Text("Reset")) {
                            game.reset()
                          })
                }.background(Color.BG)
                Spacer()
            }
            .navigationBarItems(
                leading: HStack { settingsButton; resetButton},
                trailing: questionButton
            )
        }.sheet(isPresented: $showSettingsView, onDismiss: {
            game.reset()
        }) {
            MinesweeperSettingsView(gameSettings: game.settings)
        }.sheet(isPresented: $showQuestionView) {
            MinesweeperQuestionView()
        }
    }
    
    var settingsButton: some View {
        Button(action: {
            print("Settings button pressed.")
            self.showSettingsView.toggle()
        }) {
            Image(systemName: "gearshape.fill").imageScale(.large).foregroundColor(.main)
        }
    }
    
    var resetButton: some View {
        Button(action: {
            print("Reset button pressed.")
            print(GameStatistics.totalDeaths)
            game.reset()
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

struct MinesweeperTextInfo: View {
    @ObservedObject var gameSettings: MinesweeperGameSettings
    
    var body: some View {
        HStack {
            HStack {
                Text("Bombs count: \(gameSettings.numberOfBombs)")
                    
                Image("bombIcon")
                    .resizable()
                    .frame(width: 30, height: 30)
                
            }.padding(.leading, 10)
            
            Spacer()
          
            HStack {
                Text("Health count: \(gameSettings.health)")

                Image("heart")
                    .resizable()
                    .frame(width: 25, height: 25)
            }.padding(.trailing, 10)
        }
        .frame(height: 45)
        .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.greyBG).opacity(0.75))
        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
    }
}

struct BoardView_Previews: PreviewProvider {
    private static var gameSettings = MinesweeperGameSettings()
    static var previews: some View {
        MinesweeperView()
            .environmentObject(MinesweeperGameModel(from: gameSettings))
    }
}
