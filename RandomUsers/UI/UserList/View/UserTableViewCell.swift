//
//  UserTableViewCell.swift
//  RandomUsers
//
//  Created by Илья Салей on 2.08.25.
//

import UIKit
import SDWebImage

private struct Constants {
    static let ICON_IMAGE_BORDER: CGFloat = 40
}

public struct UserTableViewCellModel {
    public let iconUrlString: String
    public let fullName: String
    public let email: String
}

public final class UserTableViewCell: UITableViewCell {
    
    public static let HEIGHT: CGFloat = 60
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.ICON_IMAGE_BORDER / 2
        return imageView
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    public override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        
        backgroundColor = .white
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        nameLabel.text = ""
        emailLabel.text = ""
    }
}

// MARK: - SETUP HELPERS
extension UserTableViewCell {
    
    public func setupCell(
        with model: UserTableViewCellModel
    ) {
        let iconUrl = URL(
            string: model.iconUrlString
        )
        
        let placeholderImage = UIImage(
            systemName: "person"
        )
        
        iconImageView.sd_setImage(
            with: iconUrl,
            placeholderImage: placeholderImage
        )
        nameLabel.text = model.fullName
        emailLabel.text = model.email
    }
}

// MARK: - LAYOUT HELPERS
extension UserTableViewCell {
    
    private func layoutElements() {
        layoutIconImageView()
        layoutNameLabel()
        layoutEmailLabel()
    }
    
    private func layoutIconImageView() {
        contentView.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 10
            ),
            iconImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
            iconImageView.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            iconImageView.heightAnchor.constraint(
                equalToConstant: Constants.ICON_IMAGE_BORDER
            ),
            iconImageView.widthAnchor.constraint(
                equalToConstant: Constants.ICON_IMAGE_BORDER
            )
        ])
    }
    
    private func layoutNameLabel() {
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(
                equalTo: iconImageView.topAnchor
            ),
            nameLabel.leadingAnchor.constraint(
                equalTo: iconImageView.trailingAnchor,
                constant: 16
            ),
            nameLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: contentView.trailingAnchor,
                constant: -16
            )
        ])
    }
    
    private func layoutEmailLabel() {
        contentView.addSubview(emailLabel)
        
        NSLayoutConstraint.activate([
            emailLabel.bottomAnchor.constraint(
                equalTo: iconImageView.bottomAnchor
            ),
            emailLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor
            ),
            emailLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: contentView.trailingAnchor,
                constant: -16
            )
        ])
    }
}
