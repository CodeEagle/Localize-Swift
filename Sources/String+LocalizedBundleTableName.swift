//
//  String+LocalizedBundleTableName.swift
//  Localize_Swift
//
//  Copyright © 2020 Roy Marmelstein. All rights reserved.
//

import Foundation

/// bundle & tableName friendly extension
public extension String {
    
    /**
     Swift 2 friendly localization syntax, replaces NSLocalizedString.
     
     - parameter tableName: The receiver’s string table to search. If tableName is `nil`
     or is an empty string, the method attempts to use `Localizable.strings`.
     
     - parameter bundle: The receiver’s bundle to search. If bundle is `nil`,
     the method attempts to use main bundle.
     
     - returns: The localized string.
     */
    func localized(using tableName: String?, in bundle: Bundle?) -> String {
        let bundle: Bundle = bundle ?? .main
        let language = Localize.currentLanguage()

        // 1. Try .lproj bundle (classic .strings / .stringsdict)
        if let path = bundle.path(forResource: language, ofType: "lproj"),
           let lprojBundle = Bundle(path: path) {
            let result = lprojBundle.localizedString(forKey: self, value: nil, table: tableName)
            if result != self { return result }
        }

        // 2. Fallback to .xcstrings (String Catalog) in the bundle root
        if let result = XCStringsLoader.shared.localizedString(
            forKey: self,
            language: language,
            tableName: tableName,
            bundle: bundle
        ) {
            return result
        }

        // 3. Base lproj fallback
        if let path = bundle.path(forResource: LCLBaseBundle, ofType: "lproj"),
           let baseBundle = Bundle(path: path) {
            return baseBundle.localizedString(forKey: self, value: nil, table: tableName)
        }

        return self
    }
    
    /**
     Swift 2 friendly localization syntax with format arguments, replaces String(format:NSLocalizedString).
     
     - parameter arguments: arguments values for temlpate (substituted according to the user’s default locale).
     
     - parameter tableName: The receiver’s string table to search. If tableName is `nil`
     or is an empty string, the method attempts to use `Localizable.strings`.
     
     - parameter bundle: The receiver’s bundle to search. If bundle is `nil`,
     the method attempts to use main bundle.
     
     - returns: The formatted localized string with arguments.
     */
    func localizedFormat(arguments: CVarArg..., using tableName: String?, in bundle: Bundle?) -> String {
        return String(format: localized(using: tableName, in: bundle), arguments: arguments)
    }
    
    /**
     Swift 2 friendly plural localization syntax with a format argument.
     
     - parameter argument: Argument to determine pluralisation.
     
     - parameter tableName: The receiver’s string table to search. If tableName is `nil`
     or is an empty string, the method attempts to use `Localizable.strings`.
     
     - parameter bundle: The receiver’s bundle to search. If bundle is `nil`,
     the method attempts to use main bundle.
     
     - returns: Pluralized localized string.
     */
    func localizedPlural(argument: CVarArg, using tableName: String?, in bundle: Bundle?) -> String {
        return NSString.localizedStringWithFormat(localized(using: tableName, in: bundle) as NSString, argument) as String
    }
    
}
