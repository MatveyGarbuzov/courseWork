//
//  ColorPickerView.swift
//  TicTacToe
//
//  Created by Matvey Garbuzov on 15.03.2022.
//

import Foundation

struct ContentView: View {
    @State private var bgColor = Color.red

    var body: some View {
        VStack {
            ColorPicker("Set the background color", selection: $bgColor)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(bgColor)
    }
}
