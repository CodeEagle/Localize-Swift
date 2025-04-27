//
//  AutoI18nable+SwiftUI.swift
//  Localize-Swift
//
//  Copyright © 2023 Roy Marmelstein. All rights reserved.
//

import Foundation

#if canImport(SwiftUI) && (os(iOS) || os(macOS) || os(tvOS) || os(watchOS))
    import SwiftUI
    import Combine

    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    public struct LocalizedText: View {
        private let key: String
        private let tableName: String?
        private let bundle: Bundle?
        @State private var currentLanguage: String = Localize.currentLanguage()

        public init(_ key: String, tableName: String? = nil, bundle: Bundle? = nil) {
            self.key = key
            self.tableName = tableName
            self.bundle = bundle
        }

        public var body: some View {
            Text(key.localized(using: tableName, in: bundle))
                .onReceive(
                    NotificationCenter.default.publisher(
                        for: Notification.Name(LCLLanguageChangeNotification))
                ) { _ in
                    self.currentLanguage = Localize.currentLanguage()
                }
        }
    }

    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    @propertyWrapper
    public struct LocalizedString: DynamicProperty {
        private let key: String
        private let tableName: String?
        private let bundle: Bundle?
        @State private var currentLanguage: String = Localize.currentLanguage()

        public init(_ key: String, tableName: String? = nil, bundle: Bundle? = nil) {
            self.key = key
            self.tableName = tableName
            self.bundle = bundle
        }

        public var wrappedValue: String {
            key.localized(using: tableName, in: bundle)
        }

        public var projectedValue: Binding<String> {
            Binding<String>(
                get: { self.wrappedValue },
                set: { _ in }
            )
        }
    }

    // Extension to make it easier to use LocalizedText
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    extension Text {
        public static func localized(_ key: String, tableName: String? = nil, bundle: Bundle? = nil)
            -> LocalizedText
        {
            LocalizedText(key, tableName: tableName, bundle: bundle)
        }
    }

    // Extension to make it easier to use LocalizedString
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    extension String {
        public static func localized(_ key: String, tableName: String? = nil, bundle: Bundle? = nil)
            -> LocalizedString
        {
            LocalizedString(key, tableName: tableName, bundle: bundle)
        }
    }
#endif
