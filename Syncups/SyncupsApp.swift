//
//  SyncupsApp.swift
//  Syncups
//
//  Created by Vitalii Kizlov on 01.12.2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct SyncupsApp: App {

    @MainActor
    static let store = Store(
        initialState: SyncUpsList.State(),
        reducer: {
            SyncUpsList()
        }
    )

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SyncUpsListView(store: Self.store)
            }
        }
    }
}
