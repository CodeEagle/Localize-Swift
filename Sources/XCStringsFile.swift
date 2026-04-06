// XCStringsFile.swift
// Localize_Swift
//
// Codable models for Apple's .xcstrings (String Catalog) format.
// Spec: https://developer.apple.com/documentation/xcode/localizing-and-varying-text-with-a-string-catalog

import Foundation

// MARK: - Root

struct XCStringsFile: Decodable, Sendable {
    let sourceLanguage: String
    let strings: [String: XCStringEntry]
    let version: String
}

// MARK: - Entry

struct XCStringEntry: Decodable, Sendable {
    let comment: String?
    let extractionState: String?
    /// Per-language localizations. Absent means "use source string as-is".
    let localizations: [String: XCLocalization]?
}

// MARK: - Localization

struct XCLocalization: Decodable, Sendable {
    /// Simple translated string.
    let stringUnit: XCStringUnit?
    /// Plural / device variations.
    let variations: XCVariations?
    /// Substitutions (stringsdict-style multi-variable plurals).
    let substitutions: [String: XCSubstitution]?
}

// MARK: - String Unit

struct XCStringUnit: Decodable, Sendable {
    /// e.g. "translated", "needs_review", "new"
    let state: String
    let value: String
}

// MARK: - Variations

struct XCVariations: Decodable, Sendable {
    /// Keyed by CLDR plural category: "zero", "one", "two", "few", "many", "other"
    let plural: [String: XCLocalization]?
    /// Keyed by device idiom: "iPhone", "iPad", "mac", etc.
    let device: [String: XCLocalization]?
}

// MARK: - Substitution (multi-variable stringsdict)

struct XCSubstitution: Decodable, Sendable {
    let argNum: Int
    let formatSpecifier: String
    let variations: XCVariations?
}
