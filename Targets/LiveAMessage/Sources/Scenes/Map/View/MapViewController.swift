//
//  MapViewController.swift
//  LiveAMessage
//
//  Created by Fernando de Lucas da Silva Gomes on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

  let viewModel = MapViewModel()
  let mapView = MapView()

  override func viewDidLoad() {
    self.view.backgroundColor = .white
    self.mapView.bind(viewModel: viewModel)
    buildHierarchy()
    setupConstraints()
    configureViews()
  }

  func buildHierarchy() {
    self.view.addSubview(mapView)
  }
  func setupConstraints() {
    mapView.setupConstraints()
  }

  func configureViews() {
  }
}
