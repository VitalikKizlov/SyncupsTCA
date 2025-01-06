//
//  SyncUpsListView.swift
//  Syncups
//
//  Created by Vitalii Kizlov on 01.12.2024.
//

import SwiftUI
import ComposableArchitecture

struct SyncUpsListView: View {
  let store: StoreOf<SyncUpsList>


  var body: some View {
    List {
      ForEach(store.syncUps) { syncUp in
        Button {


        } label: {
          CardView(syncUp: syncUp)
        }
        .listRowBackground(syncUp.theme.mainColor)
      }
      .onDelete { indexSet in
        store.send(.onDelete(indexSet))
      }
    }
    .toolbar {
      Button {
        store.send(.addSyncUpButtonTapped)
      } label: {
        Image(systemName: "plus")
      }
    }
    .navigationTitle("Daily Sync-ups")
  }
}

#Preview {
    NavigationStack {
        SyncUpsListView(
            store: .init(
                initialState: SyncUpsList.State(syncUps: [.mock]),
                reducer: {
                    SyncUpsList()
                        ._printChanges()
                }
            )
        )
    }
}
