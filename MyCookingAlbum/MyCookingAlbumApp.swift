//
//  MyCookingAlbumApp.swift
//  MyCookingAlbum
//
//  Created by Rio Nagasaki on 2022/10/01.
//

import SwiftUI

@main
struct MyCookingAlbumApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeState.initial
        }
    }
}
