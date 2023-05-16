//
//  ContentView.swift
//  CounTrivia
//
//  Created by Pedro Ceccon on 05/04/23.
//
//  The first screen, holds some vital informations and can lead to the gameplay screen

import SwiftUI
import Foundation

struct ContentView: View {
    @EnvironmentObject var model: Model
    @State var firstOpen = true
    var body: some View {
        NavigationView{
            ZStack{
                Color.appBackground
                    .ignoresSafeArea()
                VStack{
                    Spacer()
                    Text("Welcome to CounTrivia, a game designed to promote knowledge of different countries and cultures around the world. When you start a new game, you'll be presented with an outline of a country. Your goal is to guess which country it is before your time runs out. Don't worry though, you can unlock helpful tips to expand your knowledge of each country.\n\nIf you have any questions about how to play the game, you can access a tutorial at any time during gameplay. To access it, simply tap  ")
                    +
                    Text(Image(systemName: "ellipsis.circle"))
                        .foregroundColor(.accentColor)
                    +
                    Text("  in the top right corner of the screen and select 'Tutorial'. Your timer will be paused while you're in the tutorial.")
                    Spacer()
                    if firstOpen{
                        HStack{
                            Spacer()
                            NavigationLink(destination: MainScreenView().navigationBarBackButtonHidden(true), label: {
                                Text("Play")
                            })
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .font(.system(size: 24))
                            .padding(.horizontal, 24)
                            .padding(.vertical, 10)
                            .background{
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(Color.appGreen)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                                    }
                                    .shadow(radius: 2, x: -2, y: 2)
                            }
                        }
                        .padding(.bottom, 16)
                    }
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("CounTrivia")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
            .environmentObject(Model())
    }
}
