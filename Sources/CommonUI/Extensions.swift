//
//  Extensions.swift
//  CommonUI
//
//  Created by xdmgzdev on 25/03/2021.
//

import UIKit

public extension UIImage {
  enum NavigationBar {
    static var back: UIImage? { UIImage(named: Identifiers.navBarBackButtonImage) }
  }
}

public extension UIView {
  func addSubviewForAutolayout(subview: UIView) {
    subview.translatesAutoresizingMaskIntoConstraints = false
    addSubview(subview)
  }

  func addSubviewsForAutolayout(subviews: [UIView]) {
    for subview in subviews {
      subview.translatesAutoresizingMaskIntoConstraints = false
      addSubview(subview)
    }
  }
}

public extension UIColor {
  convenience init?(hex: String) {
    let rValue, gValue, bValue, aValue: CGFloat

    if hex.hasPrefix("#") {
      let start = hex.index(hex.startIndex, offsetBy: 1)
      let hexColor = String(hex[start...])

      if hexColor.count == 8 {
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0

        if scanner.scanHexInt64(&hexNumber) {
          rValue = CGFloat((hexNumber & 0xFF00_0000) >> 24) / 255
          gValue = CGFloat((hexNumber & 0x00FF_0000) >> 16) / 255
          bValue = CGFloat((hexNumber & 0x0000_FF00) >> 8) / 255
          aValue = CGFloat(hexNumber & 0x0000_00FF) / 255

          self.init(red: rValue, green: gValue, blue: bValue, alpha: aValue)
          return
        }
      }
    }

    return nil
  }
}
