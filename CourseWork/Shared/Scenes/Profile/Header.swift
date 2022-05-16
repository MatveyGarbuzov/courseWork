//
//  Header.swift
//  TicTacToe (iOS)
//
//  Created by Matvey Garbuzov on 05.05.2022.
//

import SwiftUI

struct Header: View {
    @AppStorage("red") var red = DefaultSettings.red
    @AppStorage("green") var green = DefaultSettings.green
    @AppStorage("blue") var blue = DefaultSettings.blue

    @AppStorage("xp") var xp = DefaultSettings.xp
    @AppStorage("level") var level = DefaultSettings.level
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundColor(Color(
                                    red:   red   / 255,
                                    green: green / 255,
                                    blue:  blue  / 255,
                                    opacity: 1.0
                ))
                .edgesIgnoringSafeArea(.top)
                .frame(height: 100)
            Image("userPhoto")
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
            VStack {
                ProgressBar(progress: $xp)
                    .frame(width: 150, height: 150)
                LevelLabel(xp: $xp, level: $level)
            }
        }
        
    }
}

struct LevelLabel: View {
    @Binding var xp: Double
    @Binding var level: Int
    
    var body: some View {
        VStack {
            Text("Your level: \(level) (xp: \(String(format: "%.1f", xp))/10.0)")
                .foregroundColor(.main)
            Button("Level up!") {
                print(xp)
                if xp < 9 {
                    xp += 1
                } else {
                    level += 1
                    xp = 0
                }
            }.foregroundColor(.green)
        }
    }
}

struct ProgressBar: View {
    @Binding var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.2)
                .foregroundColor(Color.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(progress * 0.1))
                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.green)
                .rotationEffect(Angle(degrees: 270))
        }
    }
}
