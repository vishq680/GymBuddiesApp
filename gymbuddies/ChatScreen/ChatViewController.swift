//
//  ChatViewController.swift
//  gymbuddies
//
//  Created by Vishaq Jayakumar on 4/18/24.
//
import UIKit
import FirebaseFirestore
import FirebaseAuth


class ChatViewController: UIViewController, UITableViewDataSource {
    var messages: [Message] = []
    let chatview = ChatView()
    
    var recipientUser: User? {
        didSet {
            recipientId = recipientUser?.id
        }
    }
    var recipientId: String?
    
    // UI components setup code here...
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = chatview
        chatview.sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        
        chatview.tableView.dataSource = self
        chatview.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "messageCell")
        
        
        listenForMessages()
        
        chatview.tableView.register(CurrentUserMessageCell.self, forCellReuseIdentifier: "CurrentUserMessageCell")
        chatview.tableView.register(OtherUserMessageCell.self, forCellReuseIdentifier: "OtherUserMessageCell")
        chatview.tableView.estimatedRowHeight = 44 // Or any estimated height
        chatview.tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    @objc func sendButtonTapped() {
        if let text = chatview.messageTextField.text {
            sendMessage(text)
        }
    }
    
    func listenForMessages() {
        guard let recipientId = recipientId, let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        let messagesRef = Firestore.firestore().collection("messages")
        let sentMessagesQuery = messagesRef
            .whereField("senderId", isEqualTo: currentUserId)
            .whereField("recipientId", isEqualTo: recipientId)
        
        let receivedMessagesQuery = messagesRef
            .whereField("senderId", isEqualTo: recipientId)
            .whereField("recipientId", isEqualTo: currentUserId)
        
        // Combine both sent and received messages into a single query
        let combinedQuery = messagesRef
            .whereField("senderId", in: [currentUserId, recipientId])
            .whereField("recipientId", in: [currentUserId, recipientId])
        
        combinedQuery.order(by: "timestamp", descending: false).addSnapshotListener { [weak self] querySnapshot, error in
            guard let strongSelf = self else { return }
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            var newMessages: [Message] = []
            snapshot.documentChanges.forEach { change in
                if change.type == .added, let messageDict = change.document.data() as? [String: Any],
                   let senderId = messageDict["senderId"] as? String,
                   let recipientId = messageDict["recipientId"] as? String,
                   let text = messageDict["text"] as? String,
                   let timestamp = messageDict["timestamp"] as? Timestamp {
                    let message = Message(senderId: senderId, recipientId: recipientId, text: text, timestamp: timestamp.dateValue().description)
                    newMessages.append(message)
                }
            }
            if !newMessages.isEmpty {
                strongSelf.messages.append(contentsOf: newMessages)
                DispatchQueue.main.async {
                    strongSelf.chatview.tableView.reloadData()
                }
            }
        }
    }
    
    
    @objc func sendMessage(_ text: String) {
        guard let recipientId = recipientId, let currentUserId = Auth.auth().currentUser?.uid, !text.isEmpty else {
            print("Failed to send message: recipientId or currentUserId is nil, or text is empty")
            return
        }
        
        let messageData: [String: Any] = [
            "senderId": currentUserId,
            "recipientId": recipientId,
            "text": text,
            "timestamp": Timestamp()
        ]
        
        Firestore.firestore().collection("messages").addDocument(data: messageData) { error in
            if let error = error {
                print("Error sending message: \(error)")
            } else {
                print("Message sent successfully")
                DispatchQueue.main.async {
                    // Create a new Message object with the sent message data
                    let newMessage = Message(senderId: currentUserId, recipientId: recipientId, text: text, timestamp: Date().description)
                    
                    // Append the new message to the messages array
                    self.messages.append(newMessage)
                    
                    // Clear the message text field here
                    self.chatview.messageTextField.text = ""
                    
                    // Print the messages array to verify it's updated
                    //                    print(self.messages ?? [])
                    
                    // Reload the tableView to display the new message
                    self.chatview.tableView.reloadData()
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let currentUserId = Auth.auth().currentUser?.uid
        
        if message.senderId == currentUserId {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentUserMessageCell", for: indexPath) as! CurrentUserMessageCell
            cell.messageLabel.text = message.text
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherUserMessageCell", for: indexPath) as! OtherUserMessageCell
            cell.messageLabel.text = message.text
            return cell
        }
    }
    
    
    
}
