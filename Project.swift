import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(name: "LiveAMessage",
                          platform: .iOS,
                          additionalTargets: ["Networking", "DesignSystem"])
