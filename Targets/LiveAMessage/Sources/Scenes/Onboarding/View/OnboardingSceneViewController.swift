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
        sceneView.animationView.loopMode = .loop
        sceneView.animationView.backgroundBehavior = .pauseAndRestore
        sceneView.animationView.animation = .named(viewModel!.animationName)
    }

    override func viewWillAppear(_ animated: Bool) {
        sceneView.animationView.play()
    }

    override func viewDidDisappear(_ animated: Bool) {
        sceneView.animationView.stop()
    }


    init(viewModel: OnboardingSceneViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        sceneView.titleLabel.text = viewModel.title
        sceneView.descriptionLabel.text = viewModel.description
        sceneView.nextButton.setTitle(viewModel.buttonTitle, for: .normal)
        sceneView.nextButtonAction = viewModel.buttonAction
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
