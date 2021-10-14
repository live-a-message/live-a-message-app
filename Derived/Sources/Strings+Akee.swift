// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum AkeeStrings {
  /// Cancel
  public static let btnCancel = AkeeStrings.tr("Localizable", "btn_cancel")
  /// Next
  public static let btnNext = AkeeStrings.tr("Localizable", "btn_next")
  /// Post
  public static let btnPost = AkeeStrings.tr("Localizable", "btn_post")
  /// Login to host messages and\n share memory with other users
  public static let lblDescriptionSignIn = AkeeStrings.tr("Localizable", "lbl_description_sign_in")
  /// Sign In
  public static let lblTitleSignIn = AkeeStrings.tr("Localizable", "lbl_title_sign_in")
  /// Close Messages
  public static let navTitleCloseMessages = AkeeStrings.tr("Localizable", "navTitle_close_messages")
  /// Write message at any place and share your feelings.
  public static let onboardingDescription1 = AkeeStrings.tr("Localizable", "onboarding_description_1")
  /// Read people messages whenever you want.
  public static let onboardingDescription2 = AkeeStrings.tr("Localizable", "onboarding_description_2")
  /// Your moments will be shared with the world from the present and the future so that moment that you lived will be forever part of the world.
  public static let onboardingDescription3 = AkeeStrings.tr("Localizable", "onboarding_description_3")
  /// Wherever you go
  public static let onboardingTitle1 = AkeeStrings.tr("Localizable", "onboarding_title_1")
  /// Whenever you want
  public static let onboardingTitle2 = AkeeStrings.tr("Localizable", "onboarding_title_2")
  /// All over the World
  public static let onboardingTitle3 = AkeeStrings.tr("Localizable", "onboarding_title_3")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension AkeeStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = AkeeResources.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
// swiftlint:enable all
// swiftformat:enable all
