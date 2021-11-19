//
//  ShowIconController.swift
//  Akee
//
//  Created by Fernando de Lucas da Silva Gomes on 17/11/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Foundation
import UIKit
import DesignSystem

class ShowIconController: UIViewController {

    let mainView = ShowIcon()
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = AKColor.mainRed
//        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismiss))
    }
}
