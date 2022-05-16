//
//  Styles.swift
//  iOS_Game (iOS)
//
//  Created by Matvey Garbuzov on 16.05.2022.
//

import Foundation
import SwiftUI

extension Text {
    func NameScoreStyle() -> some View {
        self
            .font(.largeTitle)
            .bold()
            .foregroundColor(.main)
    }
    func NumberScoreStyle() -> some View {
        self
            .foregroundColor(Color.secondary)
            
    }
}


extension Image {
    func ArrowStyle(settings: TicTacToeGameSettings) -> some View {
        self
            .rotationEffect(settings.animate ? .degrees(180) : .degrees(0))
            .animation(.spring())
        
    }
    
    func ArrowStyle(settings: ConnectFourGameSettings) -> some View {
        self
            .rotationEffect(settings.animate ? .degrees(180) : .degrees(0))
            .animation(.spring())
        
    }
}
