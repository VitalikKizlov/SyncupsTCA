//
//  SyncUpFormView.swift
//  Syncups
//
//  Created by Vitalii Kizlov on 08.12.2024.
//

import SwiftUI
import ComposableArchitecture

struct SyncUpFormView: View {
    @Perception.Bindable var store: StoreOf<SyncUpForm>
    @FocusState var focus: SyncUpForm.Field?

    var body: some View {
        Form {
            Section {
                TextField("Title", text: $store.syncUp.title)
                    .focused($focus, equals: .title)

                HStack {
                    Slider(
                        value: $store.syncUp.duration.minutes,
                        in: 5...30,
                        step: 1
                    ) {
                        Text("Length")
                    }
                    Spacer()
                    Text(store.syncUp.duration.formatted(.units()))
                }
                ThemePicker(selection: $store.syncUp.theme)
            } header: {
                Text("Sync-up Info")
            }
            Section {
                ForEach($store.syncUp.attendees) { $attendee in
                    TextField("Name", text: $attendee.name)
                        .focused($focus, equals: .attendee(attendee.id))
                }
                .onDelete { indices in
                    store.send(.onDeleteAttendees(indices))
                }

                Button("New attendee") {
                    store.send(.addAttendeeButtonTapped)
                }
            } header: {
                Text("Attendees")
            }
        }
        .bind($store.focus, to: $focus)
    }
}

#Preview {
  SyncUpFormView(
    store: Store(
      initialState: SyncUpForm.State(
        syncUp: .mock
      )
    ) {
      SyncUpForm()
    }
  )
}
