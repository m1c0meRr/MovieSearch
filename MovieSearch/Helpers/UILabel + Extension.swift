//
//  UILabel + Extension.swift
//  KinoBOX
//
//  Created by Sergey Savinkov on 12.10.2023.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont?, color: UIColor, line: Int) {
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = color
        self.numberOfLines = line
        
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
