//
//  SquareView.swift
//  TicTacToe
//
//  Created by Matvey Garbuzov on 14.03.2022.
//

import Foundation
import SwiftUI

//enum TicTacToeSquareStatus {
//    case empty
//    case home
//    case visitor
//}
//
//class Square : ObservableObject {
//    @Published var squareStatus : TicTacToeSquareStatus
//    
//    init(status : TicTacToeSquareStatus) {
//        self.squareStatus = status
//    }
//}

struct TicTacToeSquareView : View {
    @ObservedObject var dataSource : Square
    var action: () -> Void
    var size: CGFloat
    var body: some View {
        Button(action: {
            print(size)
            self.action()
        }, label: {
            Text(self.dataSource.squareStatus == .home ?
                    "X" : self.dataSource.squareStatus == .visitor ? "0" : " ")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.main)
                .frame(width: size, height: size, alignment: .center)
                .background(Color.greyBG.cornerRadius(10))
                .padding(4)
        })
    }
}
