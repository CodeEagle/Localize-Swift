//
//  IBDesignable+Localize+AppKit.swift
//  Localize-Swift
//
//  Copyright © 2023 Roy Marmelstein. All rights reserved.
//

import Foundation
#if os(macOS)
import AppKit

// MARK: - NSTextField localize Key extension for language in Interface Builder

@IBDesignable public extension NSTextField {
    @IBInspectable var localizeKey: String? {
        set {
            // set new value from dictionary
            DispatchQueue.main.async {
                self.stringValue = newValue?.localized() ?? ""
            }
        }
        get {
            return self.stringValue
        }
    }
}

// MARK: - NSButton localize Key extension for language in Interface Builder

@IBDesignable public extension NSButton {
    @IBInspectable var localizeKey: String? {
        set {
            // set new value from dictionary
            DispatchQueue.main.async {
                self.title = newValue?.localized() ?? ""
            }
        }
        get {
            return self.title
        }
    }
}

// MARK: - NSTextView localize Key extension for language in Interface Builder

@IBDesignable public extension NSTextView {
    @IBInspectable var localizeKey: String? {
        set {
            // set new value from dictionary
            DispatchQueue.main.async {
                self.string = newValue?.localized() ?? ""
            }
        }
        get {
            return self.string
        }
    }
}

// MARK: - NSMenuItem localize Key extension for language in Interface Builder

@IBDesignable public extension NSMenuItem {
    @IBInspectable var localizeKey: String? {
        set {
            // set new value from dictionary
            DispatchQueue.main.async {
                self.title = newValue?.localized() ?? ""
            }
        }
        get {
            return self.title
        }
    }
}

// MARK: - NSTabViewItem localize Key extension for language in Interface Builder

@IBDesignable public extension NSTabViewItem {
    @IBInspectable var localizeKey: String? {
        set {
            // set new value from dictionary
            DispatchQueue.main.async {
                self.label = newValue?.localized() ?? ""
            }
        }
        get {
            return self.label
        }
    }
}
#endif
