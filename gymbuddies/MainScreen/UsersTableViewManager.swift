//
//  UsersTableViewManager.swift
//  gymbuddies
//
//  Created by Vishaq Jayakumar on 4/17/24.
//

import Foundation

import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewUsersID, for: indexPath) as! UsersTableViewCell
        let user = usersList[indexPath.row]
        cell.labelName.text = user.name
        cell.labelEmail.text = user.email
        
        if let workout = user.workout {
            cell.labelWorkout.text = workout
        } else {
            cell.labelWorkout.text = "No workout preference"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = usersList[indexPath.row]
        let chatViewController = ChatViewController()
        chatViewController.recipientUser = selectedUser
        navigationController?.pushViewController(chatViewController, animated: true)
    }
    
}
