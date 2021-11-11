//
//  ARViewController.swift
//  Akee
//
//  Created by Tales Conrado on 08/11/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
import TinyConstraints
import DesignSystem

class ARViewController: UIViewController, ARSCNViewDelegate {
    let sceneView: ARSCNView = {
        let view = ARSCNView()
        return view
    }()

    let augmentedRealitySession = ARSession()
    let configuration = ARWorldTrackingConfiguration()

    private let textNode: SCNNode = SCNNode()

    private var textString: String = ""
    private let planeBackgroundColor: UIColor
    private let textColor: UIColor

    init(textString: String, textColor: UIColor = AKColor.mainRed, planeBackgroundColor: UIColor = UIColor.white) {
        self.textString = textString
        self.planeBackgroundColor = planeBackgroundColor
        self.textColor = textColor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.session = augmentedRealitySession

        configureTextNode(text: textString)
        configurePlaneNode()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        augmentedRealitySession.run(configuration, options: [.removeExistingAnchors, .resetTracking])
    }

    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }

    override func loadView() {
        view = sceneView
    }

    private func configureTextNode(text: String) {
        let text = SCNText(string: text, extrusionDepth: 2)
        text.isWrapped = true
        text.containerFrame = CGRect(x: 0.01, y: 0.01, width: 200, height: 200)
        let material = SCNMaterial()
        material.diffuse.contents = textColor

        text.materials = [material]

        textNode.scale = SCNVector3(x: 0.01, y: 0.01, z: 0.01)
        textNode.geometry = text

        sceneView.scene.rootNode.addChildNode(textNode)
        textNode.position = SCNVector3(x: 0, y: 0, z: -5)
        sceneView.autoenablesDefaultLighting = true
    }

    private func configurePlaneNode() {
        let (minVec, maxVec) = textNode.boundingBox

        let bound = SCNVector3Make(maxVec.x - minVec.x + 3,
                                   maxVec.y - minVec.y + 3,
                                   maxVec.z - minVec.z - 0.1)

        let planeBubble = SCNPlane(width: CGFloat(bound.x + 5),
                            height: CGFloat(bound.y + 5))

        let planeNode = SCNNode(geometry: planeBubble)
        planeNode.position = SCNVector3(CGFloat( minVec.x) + CGFloat(bound.x) / 2,
                                        CGFloat( minVec.y) + CGFloat(bound.y) / 2,
                                        CGFloat(minVec.z - 0.01))
        let material = SCNMaterial()
        material.diffuse.contents = planeBackgroundColor
        planeBubble.materials = [material]

        textNode.addChildNode(planeNode)
    }
}
