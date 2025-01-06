//
//  SyncUpsList.swift
//  SyncUpsList
//
//  Created by Vitalii Kizlov on 01.12.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct SyncUpsList {

    @ObservableState
    struct State: Equatable {
        var syncUps: IdentifiedArrayOf<SyncUp> = []
        @Presents var addSyncUp: SyncUpForm.State?
    }

    enum Action {
        case addSyncUpButtonTapped
        case addSyncUp(PresentationAction<SyncUpForm.Action>)
        case confirmAddButtonTapped
        case discardButtonTapped
        case onDelete(IndexSet)
        case syncUpTapped(id: SyncUp.ID)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addSyncUpButtonTapped:
                state.addSyncUp = SyncUpForm.State(syncUp: SyncUp(id: SyncUp.ID()))
                return .none
            case .addSyncUp:
                return .none
            case .confirmAddButtonTapped:
                guard let newSyncUp = state.addSyncUp?.syncUp else { return .none }
                state.syncUps.append(newSyncUp)
                state.addSyncUp = nil
                return .none
            case .discardButtonTapped:
                state.addSyncUp = nil
                return .none
            case .onDelete(let indexSet):
                state.syncUps.remove(atOffsets: indexSet)
                return .none
            case .syncUpTapped(id: let id):
                return .none
            }
        }
        .ifLet(\.$addSyncUp, action: \.addSyncUp) {
            SyncUpForm()
        }
    }
}
