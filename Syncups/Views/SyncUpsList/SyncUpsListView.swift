//
//  SyncUpsListView.swift
//  Syncups
//
//  Created by Vitalii Kizlov on 01.12.2024.
//

import SwiftUI
import ComposableArchitecture

struct SyncUpsListView: View {
    @Perception.Bindable var store: StoreOf<SyncUpsList>

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
        .sheet(
            item: $store.scope(
                state: \.addSyncUp,
                action: \.addSyncUp
                ),
            content: { addSyncUpStore in
                NavigationStack {
                    SyncUpFormView(store: addSyncUpStore)
                        .navigationTitle(Text("New Sync-up"))
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Discard") {
                                    store.send(.discardButtonTapped)
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    store.send(.confirmAddButtonTapped)
                                }
                            }
                        }
                }
            }
        )
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
