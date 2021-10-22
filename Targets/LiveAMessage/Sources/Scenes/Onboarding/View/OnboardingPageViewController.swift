//
//  OnboardingPageViewController.swift
//  Akee
//
//  Created by Albert on 07/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import DesignSystem

class OnboardingPageViewController: UIPageViewController {

    weak var coordinator: Coordinator?

    var scenes: [OnboardingSceneViewController] {
        [
            OnboardingSceneViewController(
                viewModel: .init(
                    animationName: "texting",
                    title: AkeeStrings.onboardingTitle1,
                    description: AkeeStrings.onboardingDescription1,
                    identifier: "First",
                    buttonTitle: "Next",
                    buttonAction: nextPage
                )),
            OnboardingSceneViewController(
                viewModel: .init(
                    animationName: "message_notification",
                    title: AkeeStrings.onboardingTitle2,
                    description: AkeeStrings.onboardingDescription2,
                    identifier: "Second",
                    buttonTitle: "Next",
                    buttonAction: nextPage
                )),
            OnboardingSceneViewController(
                viewModel: .init(
                    animationName: "world_messages",
                    title: AkeeStrings.onboardingTitle3,
                    description: AkeeStrings.onboardingDescription3,
                    identifier: "Third",
                    buttonTitle: AkeeStrings.lblTitleSignIn,
                    buttonAction: routeToSignIn
                ))
        ]
    }

    var currentControllerIndex = 0

    override init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey: Any]? = nil
    ) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageView()
        view.backgroundColor = .systemBackground
    }

    private func setupPageView() {
        delegate = self
        dataSource = self
        setViewControllers(
            [scenes[0]],
            direction: .forward,
            animated: true,
            completion: nil
        )
        UIPageControl.appearance(whenContainedInInstancesOf: [OnboardingPageViewController.self]).currentPageIndicatorTintColor = AKColor.mainRed
        UIPageControl.appearance(whenContainedInInstancesOf: [OnboardingPageViewController.self]).pageIndicatorTintColor = AKColor.secondaryLabel

    }

    private func nextPage() {
        guard currentControllerIndex <= scenes.count else { return }
        currentControllerIndex += 1
        setViewControllers(
            [scenes[currentControllerIndex]],
            direction: .forward,
            animated: true,
            completion: nil
        )
    }

    private func routeToSignIn() {
        coordinator?.showLogin()
    }
}

extension OnboardingPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        scenes.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        currentControllerIndex
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController)
    -> UIViewController? {
        getViewController(for: viewController, isNextController: false)
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        getViewController(for: viewController, isNextController: true)
    }

    func getViewController(
        for vc: UIViewController,
        isNextController: Bool
    ) -> UIViewController? {
        guard let vc = vc as? OnboardingSceneViewController else { return nil }
        var index: Int = 0

        index = scenes.indices.filter { scenes[$0].viewModel?.identifier == vc.viewModel?.identifier }[0]
        currentControllerIndex = index

        isNextController ? (index += 1) : (index -= 1)
        if isNextController {
            if self.scenes.count > index {
                return scenes[index]
            } else {
                return nil
            }
        } else {
            if index >= 0 {
                return scenes[index]
            } else {
                return nil
            }
        }
    }
}
