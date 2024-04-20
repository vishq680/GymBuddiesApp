//
//  ChatCellViewController.swift
//  gymbuddies
//
//  Created by Vishaq Jayakumar on 4/18/24.
//

import Foundation
import UIKit


// Custom cell for messages sent by the current user
class CurrentUserMessageCell: UITableViewCell {
    let messageLabel = PaddedLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.backgroundColor = .lightGray // Example color for the message bubble
        messageLabel.layer.cornerRadius = 6
        messageLabel.layer.masksToBounds = true
        messageLabel.numberOfLines = 0 // Allow multiple lines
        messageLabel.lineBreakMode = .byWordWrapping // Break the line by words
        messageLabel.textAlignment = .right
        contentView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250)

        ])
    }
}

// Custom cell for messages sent by the other user
class OtherUserMessageCell: UITableViewCell {
    let messageLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.backgroundColor = .white // Example color for the message bubble
        messageLabel.layer.cornerRadius = 6
        messageLabel.layer.masksToBounds = true
        messageLabel.numberOfLines = 0 // Allow multiple lines
        messageLabel.lineBreakMode = .byWordWrapping // Break the line by words
        messageLabel.textAlignment = .left
        contentView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250)
        ])
    }
}


class PaddedLabel: UILabel {
    var textInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10) // Adjust the padding as needed

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + textInsets.left + textInsets.right,
                      height: size.height + textInsets.top + textInsets.bottom)
    }
}
