//
//  UIView+Extension.swift
//  CraftDigital
//
//  Created by Simran on 08/08/21.
//

import UIKit

extension UIView {
  func cornerRadius(radius: CGFloat, corners: CACornerMask) {
    layer.cornerRadius = radius
    clipsToBounds = true
    layer.maskedCorners = corners
  }
}
