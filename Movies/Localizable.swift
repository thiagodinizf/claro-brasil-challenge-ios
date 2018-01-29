// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {

  enum Default {
    /// Oops ... no internet connection :(
    static let noConnection = L10n.tr("Localizable", "default.no_connection")
    /// No content
    static let noContent = L10n.tr("Localizable", "default.no_content")
    /// Not available
    static let notAvailable = L10n.tr("Localizable", "default.not_available")
    /// Not found on this server
    static let notFound = L10n.tr("Localizable", "default.not_found")
    /// Request canceled
    static let requestCanceled = L10n.tr("Localizable", "default.request_canceled")
    /// Service unavailable :(
    static let serverError = L10n.tr("Localizable", "default.server_error")
    /// Please try again later
    static let tryAgain = L10n.tr("Localizable", "default.try_again")
  }

  enum Favorite {
    /// Add favorite movies
    static let empty = L10n.tr("Localizable", "favorite.empty")
    /// Favorites
    static let title = L10n.tr("Localizable", "favorite.title")
  }

  enum Movie {
    /// Movie successfully removed
    static let removed = L10n.tr("Localizable", "movie.removed")
    /// Movie saved successfully
    static let saved = L10n.tr("Localizable", "movie.saved")
    /// Images
    static let sectionImages = L10n.tr("Localizable", "movie.section_images")
    /// Synopsis
    static let sectionSynopsis = L10n.tr("Localizable", "movie.section_synopsis")
    /// Trailer
    static let sectionVideos = L10n.tr("Localizable", "movie.section_videos")
  }

  enum Search {
    /// Search for movies
    static let barPlaceholder = L10n.tr("Localizable", "search.bar_placeholder")
    /// No movies found
    static let empty = L10n.tr("Localizable", "search.empty")
    /// Search
    static let title = L10n.tr("Localizable", "search.title")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
