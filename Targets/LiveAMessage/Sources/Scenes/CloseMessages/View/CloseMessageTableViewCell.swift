//
//  CloseMessageTableViewCell.swift
//  LiveAMessage
//
//  Created by Vinicius Mesquita on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit

class CloseMessageTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(viewModel: CloseMessageCellViewModel) {
        self.accessoryType = .disclosureIndicator
        self.imageView?.image = UIImage(color: .gray, size: CGSize(width: 24, height: 24))
        self.imageView?.layer.cornerRadius = 8
        self.imageView?.clipsToBounds = true
        self.textLabel?.text = "Message"
        self.detailTextLabel?.text = viewModel.message.content
    }
}

extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
