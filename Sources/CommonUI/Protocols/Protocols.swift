//
//  Protocols.swift
//  
//
//  Created by Marcos González on 23/10/2021.
//

import UIKit

public enum AdversisePosition {
	case top
	case bottom
}

public protocol Advertisable {
	var adTopView: UIView { get }
	var adBottomView: UIView { get }
	func setAdView(_ view: UIView, for position: AdversisePosition)
	func showAd(atPosition: AdversisePosition, animated: Bool)
	func hideAd(atPosition: AdversisePosition, animated: Bool)
}
