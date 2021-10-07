//
//  OnboardingSceneViewController.swift
//  Akee
//
//  Created by Albert on 07/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit

class OnboardingSceneViewController: UIViewController {

    var sceneView = OnboardingSceneView()
    var viewModel: OnboardingSceneViewModel?

    override func loadView() {
        view = sceneView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sceneView.animationView.play()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        sceneView.animationView.stop()

    }

    init(viewModel: OnboardingSceneViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        sceneView.animationView.animation = .named(viewModel.animationName)
        sceneView.titleLabel.text = viewModel.title
        sceneView.descriptionLabel.text = viewModel.description
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
