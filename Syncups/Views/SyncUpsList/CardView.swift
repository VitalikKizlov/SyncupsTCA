//
//  CardView.swift
//  Syncups
//
//  Created by Vitalii Kizlov on 01.12.2024.
//

import Foundation
import SwiftUI

struct CardView: View {
    let syncUp: SyncUp

    var body: some View {
        VStack(alignment: .leading) {
            Text(syncUp.title)
                .font(.headline)
            Spacer()
            HStack {
                Label("\(syncUp.attendees.count)", systemImage: "person.3")
                Spacer()
                Label(syncUp.duration.formatted(.units()), systemImage: "clock")
                    .labelStyle(.trailingIcon)
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(syncUp.theme.accentColor)
    }
}
