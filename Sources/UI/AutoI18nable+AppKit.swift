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
        public var i18nString: String {
            get {
                return self.stringValue
            }
            set {
                self.stringValue = newValue
            }
        }
    }
    
    // MARK: - NSButton AutoI18nable implementation
    
    extension NSButton: AutoI18nable {
        public var i18nString: String {
            get {
                return self.title
            }
            set {
                self.title = newValue
            }
        }
    }
    
    // MARK: - NSTextView AutoI18nable implementation
    
    extension NSTextView: AutoI18nable {
        public var i18nString: String {
            get {
                return self.string
            }
            set {
                self.string = newValue
            }
        }
    }
    
    // MARK: - NSMenuItem AutoI18nable implementation
    
    extension NSMenuItem: AutoI18nable {
        public var i18nString: String {
            get {
                return self.title
            }
            set {
                self.title = newValue
            }
        }
    }
    
    // MARK: - NSTabViewItem AutoI18nable implementation
    
    extension NSTabViewItem: AutoI18nable {
        public var i18nString: String {
            get {
                return self.label
            }
            set {
                self.label = newValue
            }
        }
    }
#endif
