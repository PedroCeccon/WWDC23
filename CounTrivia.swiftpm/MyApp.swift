//
//  MyApp.swift
//  CounTrivia
//
//  Created by Pedro Ceccon on 05/04/23.
//
//  main struct, just calls the View of the first screen

import SwiftUI

@main
struct MyApp: App {
    @StateObject private var model = Model()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
                .preferredColorScheme(.light)
        }
    }
}
