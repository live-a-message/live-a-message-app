//
//  AdMessageViewController.swift
//  LiveAMessage
//
//  Created by Albert on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit

class AdMessageViewController: UIViewController {
    
    private weak var viewModel: AdMessageViewModel?
    private lazy var messageView = AdMessageView()
    
    override func loadView() {
        view = messageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
