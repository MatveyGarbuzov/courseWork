//
//  ProfileView.swift
//  TicTacToe (iOS)
//
//  Created by Matvey Garbuzov on 05.05.2022.
//

import SwiftUI

struct ProfileView: View {
    @State var settingsIsPresented = false
    @State var qwerty = false
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Header()
                    ProfileText()
                }
                Spacer()
                editButton
            }.background(Color.BG).ignoresSafeArea(edges: .bottom)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: backButton,
            trailing: statsButton
        )
    }
    
    var editButton: some View {
        Button(
            action: { self.settingsIsPresented = true },
            label: {
                Label("Edit profile", systemImage: "pencil").foregroundColor(Color.main)
            }
        )
        .padding(.bottom, 50)
        .sheet(isPresented: $settingsIsPresented, content: {
            ProfileSettingsView()
        })
    }
    
    var backButton: some View {
        Image(systemName: "arrow.left")
            .foregroundColor(.main)
            .onTapGesture {
                self.presentation.wrappedValue.dismiss()
            }
    }
    
    var statsButton: some View {
        Button(
            action: { self.qwerty = true },
            label: {
                Label("Stats", systemImage: "list.bullet").foregroundColor(Color.main)
            }
        )
        .sheet(isPresented: $qwerty, content: {
            StatisticsView()
        })
    }
}



struct ProfileText: View {
    @AppStorage(UserDefaults.name) var name = DefaultSettings.name
    @AppStorage(UserDefaults.subtitle) var subtitle = DefaultSettings.subtitle
    @AppStorage(UserDefaults.description) var description = DefaultSettings.description
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                VStack(spacing: 5) {
                    Text(name)
                        .bold()
                        .font(.title)
                    
                    Text(subtitle)
                        .font(.body)
                        .foregroundColor(.secondary)
                }.padding()
                Text(description)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            }
        }
        
    }
}




struct ProfileView_Previews : PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

