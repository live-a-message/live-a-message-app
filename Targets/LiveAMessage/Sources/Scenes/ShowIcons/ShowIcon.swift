//
//  ShowIcon.swift
//  Akee
//
//  Created by Fernando de Lucas da Silva Gomes on 17/11/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import DesignSystem

class ShowIcon: UIView, ViewCode {
    var cancelAction: (() -> Void)?
    var saveAction: (() -> Void)?
    var cameraAction: (() -> Void)?

    let keyHelper = KeyboardHelper()

    private var textBottomAnchor: NSLayoutConstraint?

    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(AkeeStrings.btnCancel, for: .normal)
        button.setTitleColor(AKColor.mainRed, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        return button
    }()

    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle(AkeeStrings.btnPost, for: .normal)
        button.setTitleColor(AKColor.mainRed, for: .normal)
        button.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var collectionView: IconCollectionView = {
        let collectionView = IconCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildHierarchy()
        setupConstraints()
        configureViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func buildHierarchy() {
        addSubview(cancelButton)
        addSubview(saveButton)
        addSubview(collectionView)
    }

    func setupConstraints() {
        cancelButton.top(to: self, offset: AKSpacing.medium.value)
        cancelButton.left(to: self, offset: AKSpacing.medium.value)
        saveButton.top(to: self, offset: AKSpacing.medium.value)
        saveButton.right(to: self, offset: -AKSpacing.medium.value)
        collectionView.edges(to: self, excluding: .top)
        collectionView.topToBottom(of: cancelButton)
    }

    func configureViews() {
        backgroundColor = AKColor.mainBackgroundColor
    }

    @objc func saveButtonAction() {
        saveAction?()
    }

    @objc func cancelButtonAction() {
        cancelAction?()
    }

}

extension ShowIcon: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 20, height: 20)
    }

}
