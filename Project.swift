import ProjectDescription
import ProjectDescriptionHelpers

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:],
    "MKDirectionsApplicationSupportedModes": ["MKDirectionsModePedestrian"],
    "CFBundleDocumentTypes": [
        [
            "CFBundleTypeName": "MKDirectionsRequest",
            "LSItemContentTypes": ["com.apple.maps.directionsrequest"]
        ]
    ],
  "NSLocationWhenInUseUsageDescription": "We need the user location to show near messages based on users location"
]

let targets = [
    Target(
        name: "LiveAMessage",
        platform: .iOS,
        product: .app,
        bundleId: "io.tuist.LiveAMessage",
        deploymentTarget: .iOS(targetVersion: "13.1", devices: [.iphone]),
        infoPlist: .extendingDefault(with: infoPlist),
        sources: ["Targets/LiveAMessage/Sources/**"],
        resources: [
            "Targets/LiveAMessage/Resources/**"
        ],
        actions: [.post(script: "scripts/swiftlint.sh", name: "SwiftLint")],
        dependencies: [
            .package(product: "TinyConstraints")
        ]
    ),
    Target(
        name: "LiveAMessageTests",
        platform: .iOS,
        product: .unitTests,
        bundleId: "io.tuist.LiveAMessageTests",
        deploymentTarget: .iOS(targetVersion: "13.1", devices: [.iphone]),
        infoPlist: .extendingDefault(with: [:]),
        sources: ["Targets/LiveAMessage/Tests/**"],
        dependencies: [
            .package(product: "TinyConstraints")
        ]
    ),
    Target(
        name: "Networking",
        platform: .iOS,
        product: .framework,
        bundleId: "io.tuist.Networking",
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
        bundleId: "io.tuist.DesignSystem",
        deploymentTarget: .iOS(targetVersion: "13.1", devices: [.iphone]),
        infoPlist: .extendingDefault(with: [:]),
        sources: ["Targets/DesignSystem/**"],
        dependencies: [
            .package(product: "TinyConstraints")
        ]
    )
]

let packages: [Package] = [
    .remote(
        url: "https://github.com/roberthein/TinyConstraints",
        requirement: .exact(Version(4, 0, 2))
    )
]

let project = Project(
    name: "LiveAMessage",
    organizationName: "LiveAMessage",
    packages: packages,
    targets: targets
)
