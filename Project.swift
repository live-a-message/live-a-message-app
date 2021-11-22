import ProjectDescription
import ProjectDescriptionHelpers

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:],
    "CFBundleShortVersionString": "1.3",
    "CFBundleVersion": "1.0",
    "MKDirectionsApplicationSupportedModes": ["MKDirectionsModePedestrian"],
    "CFBundleDocumentTypes": [
        [
            "CFBundleTypeName": "MKDirectionsRequest",
            "LSHandlerRank": "Alternate",
            "LSItemContentTypes": ["com.apple.maps.directionsrequest"]
        ]
    ],
    "NSLocationWhenInUseUsageDescription": "We need the user location to show near messages based on users location",
    "LSSupportsOpeningDocumentsInPlace": "YES",
    "NSPhotoLibraryUsageDescription": "We need access to your photos so we can add them to your messages.",
    "PHPhotoLibraryPreventAutomaticLimitedAccessAlert": true
]

let targets = [
    Target(
        name: "Akee",
        platform: .iOS,
        product: .app,
        bundleId: "com.Akee.Akee",
        deploymentTarget: .iOS(targetVersion: "13.1", devices: [.iphone]),
        infoPlist: .extendingDefault(with: infoPlist),
        sources: ["Targets/LiveAMessage/Sources/**"],
        resources: [
            "Targets/LiveAMessage/Resources/**",
            "Targets/LiveAMessage/Assets.xcassets/**"
        ],
        entitlements: "Akee.entitlements",
        actions: [.post(script: "scripts/swiftlint.sh", name: "SwiftLint")],
        dependencies: [
            .target(name: "Networking"),
            .target(name: "DesignSystem")
        ]
    ),
    Target(
        name: "AkeeTests",
        platform: .iOS,
        product: .unitTests,
        bundleId: "com.Akee.AkeeTests",
        deploymentTarget: .iOS(targetVersion: "13.1", devices: [.iphone]),
        infoPlist: .extendingDefault(with: [:]),
        sources: ["Targets/LiveAMessage/Tests/**"],
        dependencies: [
            .target(name: "Akee")
        ]
    ),
    Target(
        name: "Networking",
        platform: .iOS,
        product: .framework,
        bundleId: "com.Akee.Networking",
        deploymentTarget: .iOS(targetVersion: "13.1", devices: [.iphone]),
        infoPlist: .extendingDefault(with: [:]),
        sources: ["Targets/Networking/Sources/**"],
        resources: [
            "Targets/Networking/Resources/**"
        ],
        dependencies: [

        ]
    ),
    Target(
        name: "NetworkingTests",
        platform: .iOS,
        product: .unitTests,
        bundleId: "com.Akee.NetworkingTests",
        deploymentTarget: .iOS(targetVersion: "13.1", devices: [.iphone]),
        infoPlist: .extendingDefault(with: [:]),
        sources: ["Targets/Networking/Tests/**"],
        dependencies: [
            .target(name: "Akee")
        ]
    ),
    Target(
        name: "DesignSystem",
        platform: .iOS,
        product: .framework,
        bundleId: "com.Akee.DesignSystem",
        deploymentTarget: .iOS(targetVersion: "13.1", devices: [.iphone]),
        infoPlist: .extendingDefault(with: [:]),
        sources: ["Targets/DesignSystem/**"],
        resources: [
            "Targets/DesignSystem/Resources/Assets.xcassets/**",
            "Targets/DesignSystem/Resources/**"
        ],
        dependencies: [
            TargetDependency.package(product: "Lottie"),
            TargetDependency.package(product: "TinyConstraints")
        ]
    )
]

let packages: [Package] = [
    .remote(
        url: "https://github.com/roberthein/TinyConstraints",
        requirement: .exact(Version(4, 0, 2))
    ),
    .remote(
        url: "https://github.com/airbnb/lottie-ios.git",
        requirement: .exact(Version(3, 2, 2))
    )
]

let project = Project(
    name: "Akee",
    organizationName: "Akee",
    packages: packages,
    targets: targets
)
