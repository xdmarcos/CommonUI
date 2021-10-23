//
//  BaseTableView.swift
//  CommonUI
//
//  Created by xdmgzdev on 24/03/2021.
//

import UIKit

public class BaseTableView: UIView {
	private enum ViewTraits {
		// Margins
		static let tableContentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 20.0, right: 0.0)
		// TV
		static let estimatedRowHeight: CGFloat = 80
	}
	
	public enum Accessibility {
		enum Identifier {
			static let rootView = "BaseTableViewContainer"
			static let tableView = "BaseTableView"
		}
	}
	
	// MARK: Public
	public lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.backgroundColor = .systemGray6
		tableView.separatorStyle = .none
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = ViewTraits.estimatedRowHeight
		tableView.contentInsetAdjustmentBehavior = .never
		tableView.showsVerticalScrollIndicator = false
		tableView.showsHorizontalScrollIndicator = false
		tableView.contentInset = ViewTraits.tableContentInset
		tableView.accessibilityIdentifier = Accessibility.Identifier.tableView

		return tableView
	}()
	
	override public init(frame: CGRect) {
		
		// Init
		super.init(frame: frame)
		setupUI()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}
}

private extension BaseTableView {
	func setupUI() {
		backgroundColor = .systemGray6
		accessibilityIdentifier = Accessibility.Identifier.rootView

		// Add subviews
		addSubviewForAutolayout(subview: tableView)

		// Add constraints
		addCustomConstraints()
	}

	func addCustomConstraints() {
		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
			tableView.topAnchor
				.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			tableView.bottomAnchor
				.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
		])
	}
}
