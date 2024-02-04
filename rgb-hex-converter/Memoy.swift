//  Memoy.swift
//  rgb-hex-converter
//  Created by ainnoway on 2/4/24.

import Foundation
import SwiftUI
import Cocoa
import AppKit

struct RecentNX: View {
    var button: String
    var color: Color
    var onTap: () -> Void
    var onCommandTap: () -> Void
    var body: some View {
        Button(action: {
            if commandKeyPressed() {
                onCommandTap()
            } else {
                onTap()
            }
        }) { HStack {
                Text(button)
                Spacer()
                Rectangle()
                    .fill(color)
                    .frame(width: 20, height: 20)
                    .cornerRadius(4)
            }
        .padding(.all, 7)
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}

func commandKeyPressed() -> Bool {
    return NSEvent.modifierFlags.contains(.command)
}

