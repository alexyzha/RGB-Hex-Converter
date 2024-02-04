//  rgb_hex_converterApp.swift
//  rgb-hex-converter
//  Created by alx on 2/3/24.

import Foundation
import SwiftUI
import Cocoa

class MainApp: NSObject, NSApplicationDelegate {
    var popover: NSPopover!
    var StatusBarItem: NSStatusItem!
    //app did fin
    func applicationDidFinishLaunching(_ notification: Notification) {
        //popover init
        popover = NSPopover()
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: ContentView())
        //status bar button
        StatusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = StatusBarItem.button {
            if let icon = NSImage(named: NSImage.Name("Icon")) {
                button.image = ResizeImage(image: icon, w: 18, h: 18)
                button.image?.isTemplate = true
            } else {
                button.image = NSImage(systemSymbolName: "paintbrush", accessibilityDescription: "RGB/Hex Converter")
            }
            button.action = #selector(TogglePopover(_:))
        }

    }
    //toggle popover
    @objc func TogglePopover(_ sender: Any?) {
        if let button = StatusBarItem.button {
            if popover.isShown {
                popover.performClose(sender)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
    //resize icon image
    private func ResizeImage(image: NSImage, w: CGFloat, h: CGFloat) -> NSImage {
        let TSize = NSMakeSize(w, h)
        let NewImage = NSImage(size: TSize)
        NewImage.lockFocus()
        image.draw(in: NSRect(x: 0, y: 0, width: TSize.width, height: TSize.height), from: NSRect(x: 0, y: 0, width: image.size.width, height: image.size.height), operation: NSCompositingOperation.sourceOver, fraction: 1.0)
        NewImage.unlockFocus()
        NewImage.size = TSize
        return NewImage
    }
}

//fixing the stupid extraneous window thing
let appDelegate = MainApp()
let application = NSApplication.shared
application.delegate = appDelegate
application.run()
