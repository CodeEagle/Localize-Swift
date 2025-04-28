//
//  AutoI18nable+AppKit.swift
//  Localize-Swift
//
//  Copyright © 2023 Roy Marmelstein. All rights reserved.
//

import Foundation

#if os(macOS)
    import AppKit
    extension NSTableColumn: AutoI18nable {
        public func setString(value: String, forTag tag: String? = nil) {
            switch tag {
            case "headerToolTip":
                headerToolTip = value
                break
            default:
                title = value
                break
            }
        }
    }
    extension NSSegmentedControl: AutoI18nable {
        public func setAutoLize(label: String, forSegment segment: Int) {
            autoLocalize(key: label, tag: "\(segment)")
        }

        public func setString(value: String, forTag tag: String? = nil) {
            let segmentIndex = tag.flatMap { Int($0) } ?? 0
            if segmentIndex < segmentCount {
                setLabel(value, forSegment: segmentIndex)
            }
        }
    }
    // MARK: - NSTextField AutoI18nable implementation

    extension NSTextField: AutoI18nable {
        public func setString(value: String, forTag tag: String? = nil) {
            switch tag {
            case "placeholder":
                placeholderString = value
                break
            default:
                stringValue = value
                break
            }
        }
    }

    // MARK: - NSButton AutoI18nable implementation

    extension NSButton: AutoI18nable {

        public func setString(value: String, forTag tag: String? = nil) {
            switch tag {
            case "tooltip":
                toolTip = value
            default:
                title = value
                break
            }
        }
    }

    // MARK: - NSTextView AutoI18nable implementation

    extension NSTextView: AutoI18nable {
        public func setString(value: String, forTag tag: String? = nil) {
            switch tag {
            default:
                string = value
                break
            }
        }
    }

    // MARK: - NSMenuItem AutoI18nable implementation

    extension NSMenuItem: AutoI18nable {
        public func setString(value: String, forTag tag: String? = nil) {
            switch tag {
            case "tooltip":
                toolTip = value
                break
            default:
                title = value
                break
            }
        }
    }

    // MARK: - NSTabViewItem AutoI18nable implementation

    extension NSTabViewItem: AutoI18nable {
        public func setString(value: String, forTag tag: String? = nil) {
            switch tag {
            case "tooltip":
                toolTip = value
                break
            default:
                label = value
                break
            }
        }
    }
#endif
