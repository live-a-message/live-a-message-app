import ProjectDescription
import ProjectDescriptionHelpers

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
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
        dependencies: [
//            .package(product: "Nimble")
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
//            .package(product: "Nimble")
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
        product: .app,
        bundleId: "io.tuist.DesignSystem",
        deploymentTarget: .iOS(targetVersion: "13.1", devices: [.iphone]),
        infoPlist: .extendingDefault(with: [:]),
        sources: ["Targets/DesignSystem/Sources/**"],
        dependencies: [

        ]
    )
]

let packages: [Package] = [
//    .remote(
//        url: "https://github.com/Quick/Nimble",
//        requirement: .exact(Version(9, 2, 1))
//    )
]

let project = Project(
    name: "LiveAMessage",
    organizationName: "LiveAMessage",
    packages: packages,
    targets: targets
)
