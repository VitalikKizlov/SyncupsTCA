//
//  SyncUpFormTests.swift
//  SyncupsTests
//
//  Created by Vitalii Kizlov on 06.01.2025.
//

import Foundation
import ComposableArchitecture
import Testing
@testable import Syncups

@MainActor
struct SyncUpFormTests {
    @Test
    func removeFocusedAttendee() async {
        let attendee1 = Attendee(id: Attendee.ID())
        let attendee2 = Attendee(id: Attendee.ID())

        let store = TestStore(
            initialState: SyncUpForm.State(
                focus: .attendee(attendee1.id),
                syncUp: SyncUp(
                    id: SyncUp.ID(),
                    attendees: [attendee1, attendee2]
                )
            )
        ) {
            SyncUpForm()
        }

        await store.send(.onDeleteAttendees([0])) {
            $0.focus = .attendee(attendee2.id)
            $0.syncUp.attendees = [attendee2]
        }
    }

    @Test
    func addAttendee() async {
        let store = TestStore(
            initialState: SyncUpForm.State(
                syncUp: SyncUp(id: SyncUp.ID())
            )
        ) {
            SyncUpForm()
        } withDependencies: {
            $0.uuid = .incrementing
        }

        await store.send(.addAttendeeButtonTapped) {
            $0.focus = .attendee(Attendee.ID(0))
            $0.syncUp.attendees = [Attendee(id: Attendee.ID(0))]
        }
    }

    @Test
    func removeLastAttendee() async {
        let attendee1 = Attendee(id: Attendee.ID())

        let store = TestStore(
            initialState: SyncUpForm.State(
                focus: .attendee(attendee1.id),
                syncUp: SyncUp(
                    id: SyncUp.ID(),
                    attendees: [attendee1]
                )
            )
        ) {
            SyncUpForm()
        } withDependencies: {
            $0.uuid = .incrementing
        }

        await store.send(.onDeleteAttendees([0])) {
            let attendee = Attendee(id: Attendee.ID(0))
            $0.syncUp.attendees = [attendee]
            $0.focus = .attendee(attendee.id)
        }
    }
}
