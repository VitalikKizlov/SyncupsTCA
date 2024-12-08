//
//  SyncUpsListTests.swift
//  Syncups
//
//  Created by Vitalii Kizlov on 08.12.2024.
//

import XCTest
import ComposableArchitecture
import Testing
@testable import Syncups

@MainActor
struct SyncUpsListTests {
    @Test
    func deletion() async {
        let store = TestStore(
            initialState: SyncUps.State(
                syncUps: [
                    SyncUp(
                        id: SyncUp.ID(),
                        title: "Point-Free Morning Sync"
                    )
                ]
            )
        ) {
            SyncUps()
        }

        await store.send(.onDelete([0])) {
            $0.syncUps = []
        }
    }
}
