//
//  ChatView.swift
//  gymbuddies
//
//  Created by Vishaq Jayakumar on 4/18/24.
//

import UIKit

class ChatView: UIView {
    var tableView: UITableView!
    var messageInputContainerView: UIView!
    var messageTextField: UITextField!
    var sendButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        // Initialize and add the table view
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        
        // Initialize and add the message input container view
        messageInputContainerView = UIView()
        messageInputContainerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageInputContainerView)
        
        // Initialize and add the message text field
        messageTextField = UITextField()
        messageTextField.borderStyle = .roundedRect
        messageTextField.translatesAutoresizingMaskIntoConstraints = false
        messageInputContainerView.addSubview(messageTextField)
        
        // Initialize and add the send button
        sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        messageInputContainerView.addSubview(sendButton)
    }
    
    private func setupConstraints() {
        // Constraints for tableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageInputContainerView.topAnchor)
        ])
        
        // Constraints for messageInputContainerView
        NSLayoutConstraint.activate([
            messageInputContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageInputContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            messageInputContainerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            messageInputContainerView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Constraints for messageTextField
        NSLayoutConstraint.activate([
            messageTextField.leadingAnchor.constraint(equalTo: messageInputContainerView.leadingAnchor, constant: 8),
            messageTextField.centerYAnchor.constraint(equalTo: messageInputContainerView.centerYAnchor),
            messageTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -8)
        ])
        
        // Constraints for sendButton
        NSLayoutConstraint.activate([
            sendButton.trailingAnchor.constraint(equalTo: messageInputContainerView.trailingAnchor, constant: -8),
            sendButton.centerYAnchor.constraint(equalTo: messageInputContainerView.centerYAnchor)
        ])
    }
}
