//
//  SyncUpForm.swift
//  Syncups
//
//  Created by Vitalii Kizlov on 08.12.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct SyncUpForm {

    enum Field: Hashable {
        case attendee(Attendee.ID)
        case title
    }

    @ObservableState
    struct State: Equatable {
        var focus: Field? = .title
        var syncUp: SyncUp
    }

    enum Action: BindableAction {
        case addAttendeeButtonTapped
        case binding(BindingAction<State>)
        case onDeleteAttendees(IndexSet)
    }

    @Dependency(\.uuid) var uuid

    var body: some ReducerOf<Self> {

        BindingReducer()

        Reduce { state, action in
            switch action {
            case .binding(let bindingAction):
                return .none

            case .addAttendeeButtonTapped:
                let attendee = Attendee(id: uuid())
                state.syncUp.attendees.append(attendee)
                state.focus = .attendee(attendee.id)
                return .none

            case .onDeleteAttendees(let indices):
                state.syncUp.attendees.remove(atOffsets: indices)
                guard
                    !state.syncUp.attendees.isEmpty,
                    let firstIndex = indices.first
                else {
                    let newAttendee = Attendee(id: uuid())
                    state.syncUp.attendees.append(newAttendee)
                    state.focus = .attendee(newAttendee.id)
                    return .none
                }
                let index = min(firstIndex, state.syncUp.attendees.count - 1)
                state.focus = .attendee(state.syncUp.attendees[index].id)
                return .none
            }
        }
    }
}
