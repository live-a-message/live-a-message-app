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
  /// Agree
  public static let agree = AkeeStrings.tr("Localizable", "agree")
  /// Do you really want do logout?
  public static let alertLogoutMessage = AkeeStrings.tr("Localizable", "alert_logout_message")
  /// Check what people are sharing over here!
  public static let bodyNotifCloseMessage = AkeeStrings.tr("Localizable", "body_notif_close_message")
  /// Accept the terms of service
  public static let btnAcceptTermsLogin = AkeeStrings.tr("Localizable", "btn_accept_terms_login")
  /// Block User
  public static let btnBlockUser = AkeeStrings.tr("Localizable", "btn_blockUser")
  /// Cancel
  public static let btnCancel = AkeeStrings.tr("Localizable", "btn_cancel")
  /// Delete
  public static let btnDelete = AkeeStrings.tr("Localizable", "btn_delete")
  /// Dismiss
  public static let btnDismiss = AkeeStrings.tr("Localizable", "btn_dismiss")
  /// Next
  public static let btnNext = AkeeStrings.tr("Localizable", "btn_next")
  /// Post
  public static let btnPost = AkeeStrings.tr("Localizable", "btn_post")
  /// Report
  public static let btnReport = AkeeStrings.tr("Localizable", "btn_report")
  /// Login to host messages and\n share memory with other users
  public static let lblDescriptionSignIn = AkeeStrings.tr("Localizable", "lbl_description_sign_in")
  /// Logout
  public static let lblLogout = AkeeStrings.tr("Localizable", "lbl_logout")
  /// Logout
  public static let lblLogoutProfile = AkeeStrings.tr("Localizable", "lbl_logout_profile")
  /// Privacy policy
  public static let lblPrivacyPolicy = AkeeStrings.tr("Localizable", "lbl_privacy_policy")
  /// Terms of Service
  public static let lblTermsOfService = AkeeStrings.tr("Localizable", "lbl_terms_of_service")
  /// Terms of Service
  public static let lblTermsOfServiceProfile = AkeeStrings.tr("Localizable", "lbl_termsOfService_profile")
  /// Sign In
  public static let lblTitleSignIn = AkeeStrings.tr("Localizable", "lbl_title_sign_in")
  /// Akee Message
  public static let lblTitleMessageCloseMessages = AkeeStrings.tr("Localizable", "lbl_titleMessage_close_messages")
  /// Messages
  public static let navTitleCloseMessages = AkeeStrings.tr("Localizable", "navTitle_close_messages")
  /// Map
  public static let navTitleMap = AkeeStrings.tr("Localizable", "navTitle_map")
  /// Profile
  public static let navTitleProfile = AkeeStrings.tr("Localizable", "navTitle_profile")
  /// No
  public static let no = AkeeStrings.tr("Localizable", "no")
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
  /// Pull to refresh messages
  public static let refreshCloseMessages = AkeeStrings.tr("Localizable", "refresh_close_messages")
  /// Read Messages
  public static let sectionReadCloseMessages = AkeeStrings.tr("Localizable", "section_read_close_messages")
  /// Unread Messages
  public static let sectionUnreadCloseMessages = AkeeStrings.tr("Localizable", "section_unread_close_messages")
  /// You found new messages
  public static let titleNotifCloseMessage = AkeeStrings.tr("Localizable", "title_notif_close_message")
  /// By signing up, you agree with Akee's Terms of Service and Privacy policy
  public static let txtViewTermsLogin = AkeeStrings.tr("Localizable", "txtView_terms_login")
  /// Yes
  public static let yes = AkeeStrings.tr("Localizable", "yes")
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
