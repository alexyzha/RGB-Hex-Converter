//  ConvertColor.swift
//  rgb-hex-converter
//  Created by alx on 2/3/24.

import Foundation
import SwiftUI
import AppKit

func ToRGB(_ hex: String) -> String? {
    var clean = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    clean = clean.replacingOccurrences(of: "#", with: "")
    //BUSSSSSS I LOVE BITMAXXING
    var rgb: UInt64 = 0
    guard Scanner(string: clean).scanHexInt64(&rgb) else { return nil }
    let r = (rgb & 0xFF0000) >> 16
    let g = (rgb & 0x00FF00) >> 8
    let b = rgb & 0x0000FF
    //yay bits
    return "\(r) \(g) \(b)"
}

func ToHex(r: Int, g: Int, b: Int) -> String {
    return String(format: "#%02X%02X%02X", r, g, b)
}

func ConvertAny(input: String) -> String {
    if input.starts(with: "#") || input.range(of: "^[0-9A-Fa-f]{6}$", options: .regularExpression) != nil {
        return ToRGB(input) ?? "Invalid string"
    }
    else {
        let s = input.replacingOccurrences(of: ",", with: " ")
                       .split(whereSeparator: { $0 == " " })
                       .compactMap { Int($0) }
        if s.count == 3 && s.allSatisfy({ 0...255 ~= $0 }) {
            return ToHex(r: s[0], g: s[1], b: s[2])
        }
    }
    return "Invalid string"
}

func CopyRes(_ text: String) {
    let p = NSPasteboard.general
    p.clearContents()
    p.setString(text, forType: .string)
}

extension Color {
    func ColToHex() -> String {
        //to NScolor
        let NSCol = NSColor(self)
        guard let RGB = NSCol.usingColorSpace(.sRGB) else { return "#000000" }
        let r = Int(round(RGB.redComponent * 255))
        let g = Int(round(RGB.greenComponent * 255))
        let b = Int(round(RGB.blueComponent * 255))
        return String(format: "#%02X%02X%02X", r, g, b)
    }
}

/** HELPER FOR ONCOMMANDCLICK **/

func ClipCol() -> Color? {
    let p = NSPasteboard.general
    guard let s = p.string(forType: .string) else { return nil }
    //try from hex
    if let color = FromHex(s) {
        return color
    }
    //try from rgb
    return FromRGB(s)
}

func FromHex(_ hex: String) -> Color? {
    var clean = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    clean = clean.replacingOccurrences(of: "#", with: "")
    guard clean.count == 6,
          let rgb = UInt32(clean, radix: 16) else { return nil }
    let r = Double((rgb & 0xFF0000) >> 16) / 255.0
    let g = Double((rgb & 0x00FF00) >> 8) / 255.0
    let b = Double(rgb & 0x0000FF) / 255.0
    return Color(red: r, green: g, blue: b)
}

func FromRGB(_ rgb: String) -> Color? {
    let c = rgb.split(whereSeparator: { $0 == "," || $0 == " " }).compactMap { Double($0) }
    guard c.count == 3, c.allSatisfy({ 0...255 ~= $0 }) else { return nil }
    return Color(red: c[0] / 255, green: c[1] / 255, blue: c[2] / 255)
}
