//  ContentView.swift
//  rgb-hex-converter
//  Created by ainnoway on 2/3/24.

import Foundation
import SwiftUI
import AppKit

struct ContentView: View {
    //vars
    @State private var U_IN: String = ""
    @State private var result: String = ""
    @State private var color: Color = .white
    //memoy
    @State private var memoy: [Color] = [.red, .orange, .yellow, .green, .blue]
    //main
    var body: some View {
        VStack(spacing: 0.05) {
            TextField("Enter Hex or RGB:", text: $U_IN)
                .padding(.top, 10)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .padding(.bottom, 10)
            Button("Copy Result") {
                result = ConvertAny(input: U_IN)
                if result != "Invalid string" {
                    CopyRes(result)
                }
                result = ""
                U_IN = ""
            }
            .buttonStyle(BorderlessButtonStyle())
            .padding(.bottom, 10)
            Divider()
            .padding(.bottom, 3)
            //recents
            ForEach(0..<memoy.count, id: \.self) { index in
                RecentNX(
                    button: "Copy: \(memoy[index].ColToHex())",
                    color: memoy[index],
                    onTap: {
                        //regular tap copies color
                        CopyRes(memoy[index].ColToHex())
                    },
                    onCommandTap: {
                        if let NewCol = ClipCol() {
                            memoy[index] = NewCol
                        }
                    }
                )
            }
            Divider()
            .padding(.top, 3)
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .padding(.top, 10)
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding()
        .background(Color(nsColor: .windowBackgroundColor))
        .cornerRadius(10)
        .shadow(radius: 5)
        .frame(width: 200)
    }
}
