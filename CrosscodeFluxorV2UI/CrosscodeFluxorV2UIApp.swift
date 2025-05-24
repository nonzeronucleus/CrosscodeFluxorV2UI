//
//  CrosscodeFluxorV2UIApp.swift
//  CrosscodeFluxorV2UI
//
//  Created by Ian Plumb on 23/05/2025.
//

import SwiftUI
import Factory

@main
struct CrosscodeFluxorV2UIApp: App {
    @Injected(\.store) var store

    init() {
//        CrosscodeDataLibrary.setup()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
        }
    }
}
