// XCStringsLoader.swift
// Localize_Swift
//
// Thread-safe parser and cache for .xcstrings (String Catalog) files.

import Foundation

final class XCStringsLoader: @unchecked Sendable {

    static let shared = XCStringsLoader()
    private init() {}

    // MARK: - Cache

    // Key: bundle identifier + "#" + tableName
    private var cache: [String: XCStringsFile] = [:]
    private let lock = NSLock()

    func clearCache() {
        lock.withLock { cache.removeAll() }
    }

    // MARK: - Lookup

    /// Returns the translated value for `key` in `language` from the named table inside `bundle`.
    /// Returns `nil` if the xcstrings file doesn't exist or has no translation for this key/language.
    func localizedString(
        forKey key: String,
        language: String,
        tableName: String?,
        bundle: Bundle
    ) -> String? {
        let table = tableName ?? "Localizable"
        let file = xcStringsFile(named: table, in: bundle)
        guard let entry = file?.strings[key] else { return nil }

        // No localizations → use the source string (key is the translation)
        guard let localizations = entry.localizations,
              let localization = localizations[language]
                ?? localizations[languageCode(from: language)]
        else {
            // Fallback: return nil so the caller can try lproj or key itself
            return nil
        }

        return resolvedString(from: localization)
    }

    /// Returns all languages declared in the xcstrings file (union across all tables).
    func availableLanguages(in bundle: Bundle) -> [String] {
        guard let urls = bundle.urls(forResourcesWithExtension: "xcstrings", subdirectory: nil) else {
            return []
        }
        var languages = Set<String>()
        for url in urls {
            let tableName = url.deletingPathExtension().lastPathComponent
            if let file = xcStringsFile(named: tableName, in: bundle) {
                languages.insert(file.sourceLanguage)
                file.strings.values.forEach { entry in
                    entry.localizations?.keys.forEach { languages.insert($0) }
                }
            }
        }
        return Array(languages)
    }

    // MARK: - Private helpers

    private func xcStringsFile(named table: String, in bundle: Bundle) -> XCStringsFile? {
        let cacheKey = (bundle.bundleIdentifier ?? bundle.bundlePath) + "#" + table
        return lock.withLock {
            if let cached = cache[cacheKey] { return cached }
            guard let url = bundle.url(forResource: table, withExtension: "xcstrings") else {
                return nil
            }
            guard let data = try? Data(contentsOf: url),
                  let file = try? JSONDecoder().decode(XCStringsFile.self, from: data)
            else { return nil }
            cache[cacheKey] = file
            return file
        }
    }

    /// Pick the best plain-string value out of a localization node.
    private func resolvedString(from localization: XCLocalization) -> String? {
        if let unit = localization.stringUnit {
            return unit.value
        }
        // Plural/device variations: prefer "other" as the default form
        if let plural = localization.variations?.plural {
            let preference = ["other", "many", "few", "two", "one", "zero"]
            for form in preference {
                if let resolved = plural[form].flatMap({ resolvedString(from: $0) }) {
                    return resolved
                }
            }
        }
        if let device = localization.variations?.device {
            // "iPhone" as a sensible default
            let preference = ["iPhone", "iPad", "mac", "other"]
            for idiom in preference {
                if let resolved = device[idiom].flatMap({ resolvedString(from: $0) }) {
                    return resolved
                }
            }
        }
        return nil
    }

    /// Extracts the base language code (e.g. "zh" from "zh-Hans").
    private func languageCode(from language: String) -> String {
        String(language.prefix(while: { $0 != "-" && $0 != "_" }))
    }
}

// MARK: - NSLock convenience

private extension NSLock {
    @discardableResult
    func withLock<T>(_ body: () -> T) -> T {
        lock()
        defer { unlock() }
        return body()
    }
}
