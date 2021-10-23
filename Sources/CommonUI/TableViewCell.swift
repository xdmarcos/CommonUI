//
//  BaseTableViewCell.swift
//  CommonUI
//
//  Created by xdmgzdev on 24/03/2021.
//
import UIKit

public class BaseTableViewCell: UITableViewCell {
	public static let reuseIdentifier = "BaseTableViewCellReuseIdentifier"
	private enum ViewTraits {
		// Margins
		static let sideMargin: CGFloat = 20
		static let cellMargins = UIEdgeInsets(
			top: 15,
			left: sideMargin,
			bottom: 15,
			right: sideMargin
		)
		static let innerMargin: CGFloat = 15
		static let vMargin: CGFloat = 5

		// Size
		static let symbolWidth: CGFloat = 60
		static let separatorHeight: CGFloat = 1

		// Font size
		static let fontBig: CGFloat = 28
		static let fontMedium: CGFloat = 16
		static let fontSmall: CGFloat = 12

		// UI
		static let numberOfLines = 0
		static let radius: CGFloat = 10
		static let layerBorderWidth: CGFloat = 2
	}

	public enum Accessibility {
		public enum Identifier {
			static var titleLabel = "titleLabel"
			static var symbolLabel = "symbolLabel"
			static var pathLabel = "valueLabel"
		}
	}

	public lazy var titleLabel: UILabel = {
		let titleLabel = UILabel()
		titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
		titleLabel.textColor = .label
		titleLabel.accessibilityIdentifier = Accessibility.Identifier.titleLabel
		return titleLabel
	}()
	public lazy var symbolLabel: UILabel = {
		let symbolLabel = UILabel()
		symbolLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
		symbolLabel.textColor = .label
		symbolLabel.textAlignment = .center
		symbolLabel.accessibilityIdentifier = Accessibility.Identifier.symbolLabel
		symbolLabel.layer.cornerRadius = ViewTraits.radius
		symbolLabel.layer.masksToBounds = true
		symbolLabel.layer.borderWidth = ViewTraits.layerBorderWidth
		symbolLabel.layer.borderColor = UIColor.label.cgColor
		return symbolLabel
	}()
	public lazy var detailLabel: UILabel = {
		let detailLabel = UILabel()
		detailLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
		detailLabel.textColor = .secondaryLabel
		detailLabel.textAlignment = .left
		detailLabel.lineBreakMode = .byTruncatingHead
		detailLabel.numberOfLines = ViewTraits.numberOfLines
		detailLabel.accessibilityIdentifier = Accessibility.Identifier.pathLabel
		return detailLabel
	}()
	private lazy var separatorView: UIView = {
		let separatorView = UIView()
		separatorView.backgroundColor = .systemGray2
		return separatorView
	}()

	override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	override public func prepareForReuse() {
		super.prepareForReuse()

		titleLabel.text = ""
		symbolLabel.text = ""
		detailLabel.text = ""
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}
}

private extension BaseTableViewCell {
	func setupUI() {
		selectionStyle = .none
		backgroundColor = .systemGray6

		// Add subviews
		contentView.addSubviewsForAutolayout(subviews: [
												symbolLabel,
												titleLabel,
												detailLabel,
												separatorView
		])

		// Add constraints
		addCustomConstraints()
	}

	func addCustomConstraints() {
		NSLayoutConstraint.activate([
			symbolLabel.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: ViewTraits.sideMargin
			),
			symbolLabel.widthAnchor
				.constraint(equalToConstant: ViewTraits.symbolWidth),
			symbolLabel.centerYAnchor
				.constraint(equalTo: contentView.centerYAnchor),

			titleLabel.leadingAnchor.constraint(
				equalTo: symbolLabel.trailingAnchor,
				constant: ViewTraits.innerMargin
			),
			titleLabel.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -ViewTraits.cellMargins.right
			),
			titleLabel.topAnchor.constraint(
				equalTo: contentView.topAnchor,
				constant: ViewTraits.cellMargins.top
			),

			detailLabel.leadingAnchor.constraint(
				equalTo: symbolLabel.trailingAnchor,
				constant: ViewTraits.innerMargin
			),
			detailLabel.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -ViewTraits.cellMargins.right
			),
			detailLabel.topAnchor.constraint(
				equalTo: titleLabel.bottomAnchor,
				constant: ViewTraits.vMargin
			),
			detailLabel.bottomAnchor.constraint(
				equalTo: contentView.bottomAnchor,
				constant: -ViewTraits.cellMargins.bottom
			),

			separatorView.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: ViewTraits.cellMargins.left
			),
			separatorView.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -ViewTraits.cellMargins.right
			),
			separatorView.bottomAnchor
				.constraint(equalTo: contentView.bottomAnchor),
			separatorView.heightAnchor
				.constraint(equalToConstant: ViewTraits.separatorHeight),
		])
	}
}
