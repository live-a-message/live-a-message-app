//
//  MapView.swift
//  LiveAMessage
//
//  Created by Fernando de Lucas da Silva Gomes on 14/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit
import MapKit
import DesignSystem
import TinyConstraints

class MapView: MKMapView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.isZoomEnabled = true
    self.isZoomEnabled = true
    self.tintColor = Colors.mainRed
    self.showsUserLocation = true
    self.translatesAutoresizingMaskIntoConstraints = false
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupConstraints() {
    self.edgesToSuperview()
  }

}
