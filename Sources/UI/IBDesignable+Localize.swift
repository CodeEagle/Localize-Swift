//
//  IBDesignable+Localize.swift
//  Localize-Swift
//
//  Copyright © 2020 Roy Marmelstein. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS)
    import UIKit

    // MARK: - UILabel localize Key extention for language in story board

    @IBDesignable extension UILabel {
        @IBInspectable public var localizeKey: String? {
            set {
                // set new value from dictionary
                DispatchQueue.main.async {
                    self.text = newValue?.localized()
                }
            }
            get {
                return self.text
            }
        }
    }

    // MARK: - UIButton localize Key extention for language in story board

    @IBDesignable extension UIButton {

        @IBInspectable public var localizeKey: String? {
            set {
                // set new value from dictionary
                DispatchQueue.main.async {
                    self.setTitle(newValue?.localized(), for: .normal)
                }
            }
            get {
                return self.titleLabel?.text
            }
        }
    }

    // MARK: - UITextView localize Key extention for language in story board

    @IBDesignable extension UITextView {

        @IBInspectable public var localizeKey: String? {
            set {
                // set new value from dictionary
                DispatchQueue.main.async {
                    self.text = newValue?.localized()
                }
            }
            get {
                return self.text
            }
        }
    }

    // MARK: - UITextField localize Key extention for language in story board

    @IBDesignable extension UITextField {
        @IBInspectable public var localizeKey: String? {
            set {
                // set new value from dictionary
                DispatchQueue.main.async {
                    self.placeholder = newValue?.localized()
                }
            }
            get {
                return self.placeholder
            }
        }
    }

    // MARK: - UINavigationItem localize Key extention for language in story board

    @IBDesignable extension UINavigationItem {

        @IBInspectable public var localizeKey: String? {
            set {
                // set new value from dictionary
                DispatchQueue.main.async {
                    self.title = newValue?.localized()
                }
            }
            get {
                return self.title
            }
        }
    }
#endif
