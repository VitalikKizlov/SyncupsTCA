//
//  SyncUps.swift
//  SyncUps
//
//  Created by Vitalii Kizlov on 01.12.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct SyncUps {

    @ObservableState
    struct State: Equatable {
        var syncUps: IdentifiedArrayOf<SyncUp> = []
    }

    enum Action {
        case addSyncUpButtonTapped
        case onDelete(IndexSet)
        case syncUpTapped(id: SyncUp.ID)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addSyncUpButtonTapped:
                return .none
            case .onDelete(let indexSet):
                state.syncUps.remove(atOffsets: indexSet)
                return .none
            case .syncUpTapped(id: let id):
                return .none
            }
        }
    }
}
