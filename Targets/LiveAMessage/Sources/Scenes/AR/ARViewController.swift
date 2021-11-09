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

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.session = augmentedRealitySession
        let text = SCNText(string: "Teste pequeno gigabytes de texto e uma coisa fenomental esdrurqowe qnad adqWLOREM IPSUSUS", extrusionDepth: 2)
        text.isWrapped = true
        text.containerFrame = CGRect(x: 0.01, y: 0.01, width: 200, height: 200)
        let outroMaterial = SCNMaterial()
        outroMaterial.diffuse.contents = AKColor.mainRed

        text.materials = [outroMaterial]

        let node = SCNNode()
        node.scale = SCNVector3(x: 0.01, y: 0.01, z: 0.01)
        node.geometry = text

        sceneView.scene.rootNode.addChildNode(node)
        node.position = SCNVector3(x: 0, y: 0, z: -5)
        sceneView.autoenablesDefaultLighting = true

        let (minVec, maxVec) = node.boundingBox

        let bound = SCNVector3Make(maxVec.x - minVec.x + 3,
                                   maxVec.y - minVec.y + 3,
                                   maxVec.z - minVec.z - 0.1)

        let planeBubble = SCNPlane(width: CGFloat(bound.x + 5),
                            height: CGFloat(bound.y + 5))

        let planeNode = SCNNode(geometry: planeBubble)
        planeNode.position = SCNVector3(CGFloat( minVec.x) + CGFloat(bound.x) / 2,
                                        CGFloat( minVec.y) + CGFloat(bound.y) / 2,
                                        CGFloat(minVec.z - 0.01))

        node.addChildNode(planeNode)
        planeNode.name = "text"

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        augmentedRealitySession.run(configuration, options: [.removeExistingAnchors, .resetTracking])
    }

    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }

    override func loadView() {
        view = sceneView
    }
}
