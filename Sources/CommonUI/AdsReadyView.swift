//
//  AdsReadyView.swift
//  
//
//  Created by Marcos González on 23/10/2021.
//

import UIKit

public class AdsReadyView: UIView {
	// MARK:- Private
	private enum ViewTraits {
		static let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		static let topAdInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		static let bottomAdtInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		static let animtionDuration: TimeInterval = 0.3
		static let maximumAlpha: CGFloat = 1
	}

	private var topAdHeightConstraint: NSLayoutConstraint!
	private var bottomAdHeightConstraint: NSLayoutConstraint!
	private var advertismentView: UIView?

	// MARK:- Public
	public var contentView: UIView = {
		let contentView = UIView()
		contentView.backgroundColor = .systemBackground
		return contentView
	}()

	public var adTopView: UIView = {
		let adTopView = UIView()
		adTopView.backgroundColor = .systemBackground
		adTopView.alpha = 0
		adTopView.contentMode = .center
		return adTopView
	}()

	public var adBottomView: UIView = {
		let adBottomView = UIView()
		adBottomView.backgroundColor = .systemBackground
		adBottomView.alpha = 0
		adBottomView.contentMode = .center
		return adBottomView
	}()

	public override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}
}

extension AdsReadyView: Advertisable {
	public func setAdView(_ view: UIView, for position: AdversisePosition) {
		advertismentView = view

		switch position {
		case .top:
			adTopView.addSubviewForAutolayout(subview: view)
		case .bottom:
			adBottomView.addSubviewForAutolayout(subview: view)
		}
	}

	public func showAd(atPosition: AdversisePosition, animated: Bool) {
		switch atPosition {
		case .top:
			animateTopAd(show: true, animated: animated)

		case .bottom:
			animateBottomAd(show: true, animated: animated)
		}
	}

	public func hideAd(atPosition: AdversisePosition, animated: Bool) {
		switch atPosition {
		case .top:
			animateTopAd(show: false, animated: animated)
		case .bottom:
			animateBottomAd(show: false, animated: animated)
		}
	}

	func animateTopAd(show: Bool, animated: Bool) {
		guard let adView = advertismentView else { return }

		UIView.animate(withDuration: ViewTraits.animtionDuration) {
			self.topAdHeightConstraint.constant = show ? adView.bounds.height : 0
			self.adTopView.alpha = show ? ViewTraits.maximumAlpha : 0
		}
	}

	func animateBottomAd(show: Bool, animated: Bool) {
		guard let adView = advertismentView else { return }

		UIView.animate(withDuration: ViewTraits.animtionDuration) {
			self.adBottomView.alpha = show ? ViewTraits.maximumAlpha : 0
			self.bottomAdHeightConstraint.constant = show ? adView.bounds.height : 0
		}
	}
}

private extension AdsReadyView {
	func setupUI() {
		// Add subviews
		addSubviewForAutolayout(subview: adTopView)
		addSubviewForAutolayout(subview: adBottomView)
		addSubviewForAutolayout(subview: contentView)

		// Add constraints
		addCustomConstraints()
	}

	func addCustomConstraints() {
		NSLayoutConstraint.activate([
			adTopView.topAnchor.constraint(equalTo: topAnchor, constant: ViewTraits.topAdInset.top),
			adTopView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewTraits.topAdInset.bottom),
			adTopView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTraits.topAdInset.left),
			adTopView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewTraits.topAdInset.right),

			contentView.topAnchor.constraint(equalTo: adTopView.bottomAnchor, constant: ViewTraits.contentInset.top),
			contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTraits.contentInset.left),
			contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewTraits.contentInset.right),
			contentView.bottomAnchor.constraint(equalTo: adBottomView.topAnchor, constant: -ViewTraits.contentInset.bottom),

			adBottomView.topAnchor.constraint(equalTo: bottomAnchor, constant: ViewTraits.bottomAdtInset.top),
			adBottomView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewTraits.bottomAdtInset.bottom),
			adBottomView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTraits.bottomAdtInset.left),
			adBottomView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewTraits.bottomAdtInset.right),

		])

		topAdHeightConstraint = adTopView.heightAnchor.constraint(equalToConstant: 0)
		topAdHeightConstraint.isActive = true
		bottomAdHeightConstraint = adBottomView.heightAnchor.constraint(equalToConstant: 0)
		bottomAdHeightConstraint.isActive = true
	}
}
