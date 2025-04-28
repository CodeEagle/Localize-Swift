//
//  AutoI18nable+AppKit.swift
//  Localize-Swift
//
//  Copyright © 2023 Roy Marmelstein. All rights reserved.
//

import Foundation

#if os(macOS)
    import AppKit

    // MARK: - NSTextField AutoI18nable implementation

    extension NSTextField: AutoI18nable {
        public func setString(value: String, forTag tag: String?) {
            stringValue = value
        }
    }

    // MARK: - NSButton AutoI18nable implementation

    extension NSButton: AutoI18nable {

        public func setString(value: String, forTag tag: String?) {
            switch tag {
            case "title":
                title = value
            case "tooltip":
                toolTip = value
            default:
                break
            }
        }
    }

    // MARK: - NSTextView AutoI18nable implementation

    extension NSTextView: AutoI18nable {
        public func setString(value: String, forTag tag: String?) {
            switch tag {
            case "string":
                string = value
            default:
                break
            }
        }
    }

    // MARK: - NSMenuItem AutoI18nable implementation

    extension NSMenuItem: AutoI18nable {
        public func setString(value: String, forTag tag: String?) {
            switch tag {
            case "title":
                title = value
            case "tooltip":
                toolTip = value
            default:
                break
            }
        }
    }

    // MARK: - NSTabViewItem AutoI18nable implementation

    extension NSTabViewItem: AutoI18nable {
        public func setString(value: String, forTag tag: String?) {
            switch tag {
            case "label":
                label = value
            case "tooltip":
                toolTip = value
            default:
                break
            }
        }
    }
#endif
