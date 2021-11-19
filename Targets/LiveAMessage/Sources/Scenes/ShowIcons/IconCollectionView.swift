//
//  IconCollectionView.swift
//  Akee
//
//  Created by Fernando de Lucas da Silva Gomes on 17/11/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Foundation
import UIKit

class IconCollectionView: UICollectionView{
  init(){
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    super.init(frame: .zero, collectionViewLayout: layout)
    self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    self.backgroundColor = .systemBackground
    self.translatesAutoresizingMaskIntoConstraints = false
    self.showsVerticalScrollIndicator = false
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
