import ProjectDescription
import ProjectDescriptionHelpers

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:],
    "MKDirectionsApplicationSupportedModes": ["MKDirectionsModePedestrian"],
    "CFBundleDocumentTypes": [
        [
            "CFBundleTypeName": "MKDirectionsRequest",
            "LSHandlerRank": "Alternate",
            "LSItemContentTypes": ["com.apple.maps.directionsrequest"]
        ]
    ],
    "NSLocationWhenInUseUsageDescription": "We need the user location to show near messages based on users location",
    "LSSupportsOpeningDocumentsInPlace": "YES"
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
        actions: [.post(script: "scripts/swiftlint.sh", name: "SwiftLint")],
        dependencies: [
            .package(product: "TinyConstraints"),
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
        dependencies: [ ]
    ),
    Target(
        name: "Networking",
        platform: .iOS,
        product: .framework,
        bundleId: "com.Akee.Networking",
        deploymentTarget: .iOS(targetVersion: "13.1", devices: [.iphone]),
        infoPlist: .extendingDefault(with: [:]),
        sources: ["Targets/Networking/**"],
        dependencies: [

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
            "Targets/DesignSystem/Resources/Assets.xcassets/**"
        ],
        dependencies: [ ]
    )
]

let packages: [Package] = [
    .remote(
        url: "https://github.com/roberthein/TinyConstraints",
        requirement: .exact(Version(4, 0, 2))
    )
]

let project = Project(
    name: "Akee",
    organizationName: "Akee",
    packages: packages,
    targets: targets
)
