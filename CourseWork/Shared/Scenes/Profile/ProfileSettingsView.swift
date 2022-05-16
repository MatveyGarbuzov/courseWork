//
//  SettingsView.swift
//  TicTacToe (iOS)
//
//  Created by Matvey Garbuzov on 05.05.2022.
//

import SwiftUI

struct ProfileSettingsView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                HeaderBackgroundSliders()
                ProfileSettings()
            }
            .navigationBarTitle(Text("Settings"))
            .navigationBarItems(
                trailing:
                    Button (
                        action: {
                            self.presentationMode.wrappedValue.dismiss()
                        },
                        label: {
                            Text("Done")
                        }
                    )
            )
        }
    }
}

struct ProfileSettings: View {
    @AppStorage(UserDefaults.name) var name = DefaultSettings.name
    @AppStorage(UserDefaults.subtitle) var subtitle = DefaultSettings.subtitle
    @AppStorage(UserDefaults.description) var description = DefaultSettings.description
    
    var body: some View {
        Section(header: Text("Profile")) {
            Button (
                action: {
                    // Action
                },
                label: {
                    Text("Pick Profile Image")
                }
            )
            TextField("Name", text: $name)
            TextField("Subtitle", text: $subtitle)
            TextEditor(text: $description)
        }
    }
}

struct HeaderBackgroundSliders: View {
    @AppStorage("red") var red = DefaultSettings.red
    @AppStorage("green") var green = DefaultSettings.green
    @AppStorage("blue") var blue = DefaultSettings.blue
    
    var body: some View {
        Section(header: Text("Header Background Color")) {
            HStack {
                VStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 100)
                        .foregroundColor(Color(
                                            red: red     / 255,
                                            green: green / 255,
                                            blue: blue   / 255,
                                            opacity: 1.0
                        ))
                }
                VStack {
                    colorSlider(value: $red, textColor: .red)
                    colorSlider(value: $green, textColor: .green)
                    colorSlider(value: $blue, textColor: .blue)
                }
            }
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsView()
    }
}
