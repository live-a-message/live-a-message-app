// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum AkeeAsset {
  public static let icClose = AkeeImages(name: "ic_close")
  public static let icIndicator = AkeeImages(name: "ic_indicator")
  public static let icLocation = AkeeImages(name: "ic_location")
  public static let icLocatonSelected = AkeeImages(name: "ic_locaton_selected")
  public static let mapDark = AkeeImages(name: "map_dark")
  public static let pinzinhoEmptyState = AkeeImages(name: "pinzinho_empty_state")
  public static let avatar = AkeeImages(name: "avatar")
  public static let marker = AkeeImages(name: "marker")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public struct AkeeImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = AkeeResources.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

public extension AkeeImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the AkeeImages.image property")
  convenience init?(asset: AkeeImages) {
    #if os(iOS) || os(tvOS)
    let bundle = AkeeResources.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:enable all
// swiftformat:enable all
