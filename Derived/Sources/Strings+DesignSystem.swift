// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum DesignSystemStrings {
  /// Any data around here!
  public static let lblGenericEmptyState = DesignSystemStrings.tr("Localizable", "lbl_generic_emptyState")
  /// Error when processing request!
  public static let loadingFailed = DesignSystemStrings.tr("Localizable", "loading_failed")
  /// Done!
  public static let loadingSuccess = DesignSystemStrings.tr("Localizable", "loading_success")
  /// Working...
  public static let loadingWorking = DesignSystemStrings.tr("Localizable", "loading_working")
  /// Okay
  public static let ok = DesignSystemStrings.tr("Localizable", "ok")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension DesignSystemStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = DesignSystemResources.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
// swiftlint:enable all
// swiftformat:enable all
