//
//  ReadMeApp.swift
//  ReadMe
//
//  Created by Omar Khaled on 05/02/2022.
//

import SwiftUI

@main
struct ReadMeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Library())
        }
    }
}
