//
//  Extensions.swift
//  Syncups
//
//  Created by Vitalii Kizlov on 08.12.2024.
//

extension Duration {
    var minutes: Double {
        get { Double(components.seconds / 60) }
        set { self = .seconds(newValue * 60) }
    }
}
