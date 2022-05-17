//
//  ConnectFourSettingsView.swift
//  TicTacToe (iOS)
//
//  Created by Matvey Garbuzov on 08.05.2022.
//

import SwiftUI

struct ConnectFourSettingsView: View {
    @StateObject var settings: ConnectFourGameSettings
    @EnvironmentObject var game: ConnectFourGameModel
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("First player color")) {

                    HStack {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(0 ..< settings.arrayOfColorsForFirstPlayer.count, content: { colorIndex in
                                    Circle()
                                        .frame(width: settings.firstPlayerColor == settings.arrayOfColorsForFirstPlayer[colorIndex] ?  50 : 40,
                                               height: settings.firstPlayerColor == settings.arrayOfColorsForFirstPlayer[colorIndex] ?  50 : 40)
                                        .opacity(settings.firstPlayerColor == settings.arrayOfColorsForFirstPlayer[colorIndex] ? 1.0 : 0.6)
                                        
                                        .foregroundColor(settings.arrayOfColorsForFirstPlayer[colorIndex])
                                        .onTapGesture {
                                            print(colorIndex)
                                            game.resetGameBoard()
                                            settings.firstPlayerColor = settings.arrayOfColorsForFirstPlayer[colorIndex]
                                        }
                                        .animation(.linear(duration: 0.5))
                                })
                            }
                        }
                    }
                }
                Section(header: Text("Second player color")) {
                    HStack {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(0 ..< settings.arrayOfColorsForFirstPlayer.count, content: { colorIndex in
                                    Circle()
                                        .frame(width: settings.secondPlayerColor == settings.arrayOfColorsForSecondPlayer[colorIndex] ?  50 : 40,
                                               height: settings.secondPlayerColor == settings.arrayOfColorsForSecondPlayer[colorIndex] ?  50 : 40)
                                        .opacity(settings.secondPlayerColor == settings.arrayOfColorsForSecondPlayer[colorIndex] ? 1.0 : 0.6)
                                        
                                        .foregroundColor(settings.arrayOfColorsForSecondPlayer[colorIndex])
                                        .onTapGesture {
                                            print(colorIndex)
                                            game.resetGameBoard()
                                            settings.secondPlayerColor = settings.arrayOfColorsForSecondPlayer[colorIndex]
                                        }
                                        .animation(.linear(duration: 0.5))
                                })
                            }
                        }
                    }
                }

            }
            .navigationTitle("Connect Four Settings")
        }
        Spacer()
    }
}

struct ConnectFourSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectFourSettingsView(settings: ConnectFourGameSettings())
    }
}
