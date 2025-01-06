//
//  ContentView.swift
//  Syncups
//
//  Created by Vitalii Kizlov on 01.12.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            SyncUpsListView(
                store: .init(
                    initialState: SyncUpsList.State(),
                    reducer: {
                        SyncUpsList()
                    }
                )
            )
        }
    }
}

#Preview {
    ContentView()
}
