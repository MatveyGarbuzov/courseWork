//
//  ContentView.swift
//  Shared
//
//  Created by Matvey Garbuzov on 13.03.2022.
//

import SwiftUI

extension Text {
    func GameNameHeader() -> some View {
        self
            .padding(10)
            .foregroundColor(Color.main)
            .opacity(0.9)
            .font(.system(size: 30))
    }
}

extension VStack {
    func GameStack() -> some View {
        self
            .frame(width: 300, height: 200)
            .padding()
            .background(Color.greyBG)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
    }
}

enum Games: String, CaseIterable{ //Please find a better name ;)
    case TicTacToe, Minesweeper, ConnectFour
    
    var image: String { // get the assetname of the image
        switch self{
        case .TicTacToe:
            return "TicTacToe"
        case .Minesweeper:
            return "Minesweeper"
        case .ConnectFour:
            return "ConnectFour"
        }
    }
    
    var text: String { // get the assetname of the image
        switch self{
        case .TicTacToe:
            return "Tic Tac Toe"
        case .Minesweeper:
            return "Minesweeper"
        case .ConnectFour:
            return "Connect Four"
        }
    }

    @ViewBuilder
    var detailView: some View { // create the view here, if you need to add
        switch self {           // paramaters use a function or associated
        case .TicTacToe:          // values for your enum cases
            TicTacToeView()
                .environmentObject(TicTacToeGameModel(from: TicTacToeGameSettings()))
        case .Minesweeper:
            MinesweeperView().environmentObject(MinesweeperGameModel(from: MinesweeperGameSettings()))
        case .ConnectFour:
            ConnectFourView()
                .environmentObject(ConnectFourGameModel(from: ConnectFourGameSettings()))
        }
    }
}

struct MainView: View {
    
    init() {
        UINavigationBar.appearance().tintColor = UIColor(Color.main)
    }
    
    var body: some View {
        NavigationView{ // Add the NavigationView
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(Games.allCases, id:\.self) { imageEnum in // Itterate over all enum cases
                        NavigationLink(destination: imageEnum.detailView){ // get detailview here
                            VStack {
                                Image(imageEnum.image)
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color.main)
                            
                                Text(imageEnum.text).bold()
                                    .GameNameHeader()
                            }
                            .GameStack()
                        }.shadow(radius: 5)
                    }
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .center
                )
                .padding(.top, 10)
                .navigationBarTitle("Choose the game")
                .navigationBarItems(trailing: NavigationLink(destination: ProfileView()) {
                    Image(systemName: "person.crop.circle").imageScale(.large)
                })
            }.background(Color.BG).ignoresSafeArea(edges: .bottom)
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
