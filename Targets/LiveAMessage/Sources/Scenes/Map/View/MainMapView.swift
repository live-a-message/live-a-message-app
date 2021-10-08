//
//  MainMapView.swift
//  LiveAMessage
//
//  Created by Fernando de Lucas da Silva Gomes on 20/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit
import MapKit
import DesignSystem

class MainMapView: UIView, ViewCode {

    var didTapPin: ((MKAnnotation?) -> Void)? {
        didSet {
            mapView.didTapPin = didTapPin
        }
    }

    let mapView = MapView()

    let headerView = MapHeaderView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildHierarchy()
        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildHierarchy() {
        self.addSubview(mapView)
        self.addSubview(headerView)
    }

    func setupConstraints() {
        self.edgesToSuperview()
    }

    func configureViews() {
        mapView.setupConstraints()
        headerView.setupConstraints()
    }

    func bind(viewModel: MapViewModelProtocol) {
        viewModel.mapView = self.mapView
    }

    func didTapPinMessage(_ annotation: MKAnnotation?) {
        didTapPin?(annotation)
    }
}
