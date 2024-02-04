//  ColorWheel.swift
//  rgb-hex-converter
//  Created by alx on 2/4/24.

import Foundation
import AppKit

func OpenPicker() {
    // Assuming `self.popover` is your NSPopover instance
    self.popover.performClose(nil) // Close the main popover menu
    
    let colorPanel = NSColorPanel.shared
    colorPanel.showsAlpha = true
    colorPanel.isContinuous = false
    colorPanel.setTarget(self)
    colorPanel.setAction(#selector(colorPanelColorChanged(_:)))
    colorPanel.makeKeyAndOrderFront(nil)

    // Enable the color picker's magnifying glass feature
    colorPanel.showsAlpha = true // Optionally allow alpha selection
    NSColorPanel.setPickerMask(NSColorPanel.PickerMask.all)
    NSColorPanel.setPickerMode(NSColorPanel.Mode.crayon) // You can set this to your preferred mode
}

@objc func colorPanelColorChanged(_ sender: NSColorPanel) {
    let selectedColor = sender.color
    
}
