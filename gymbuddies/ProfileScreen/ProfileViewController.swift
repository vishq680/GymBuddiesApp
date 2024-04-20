//
//  ProfileViewController.swift
//  gymbuddies
//
//  Created by Vishaq Jayakumar on 4/18/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var profileView: ProfileView!
    let database = Firestore.firestore()
    var currentUser: FirebaseAuth.User?
    var workouts: [String] = ["Chest", "Triceps", "Biceps", "Back", "Legs", "Shoulder", "Abs"]
    var selectedWorkout: String?
    
    override func loadView() {
        profileView = ProfileView()
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        currentUser = Auth.auth().currentUser
        loadUserProfile()
        profileView.pickerViewWorkout.delegate = self
        profileView.pickerViewWorkout.dataSource = self
        profileView.buttonUpdateWorkout.addTarget(self, action: #selector(updateWorkout), for: .touchUpInside)
    }
    
    private func loadUserProfile() {
        guard let currentUser = currentUser else { return }
        database.collection("users").document(currentUser.uid).getDocument { [weak self] (document, error) in
            if let document = document, document.exists, let userData = document.data() {
                DispatchQueue.main.async {
                    self?.profileView.labelEmail.text = "Email: \(userData["email"] as? String ?? "")"
                    self?.profileView.labelName.text = "Name: \(userData["name"] as? String ?? "")"
                    if let workoutIndex = self?.workouts.firstIndex(of: userData["workout"] as? String ?? "") {
                        self?.profileView.pickerViewWorkout.selectRow(workoutIndex, inComponent: 0, animated: false)
                    }
                }
            }
        }
    }
    
    @objc private func updateWorkout() {
        guard let currentUser = currentUser, let selectedWorkout = selectedWorkout else { return }
        database.collection("users").document(currentUser.uid).updateData([
            "workout": selectedWorkout
        ]) { [weak self] error in
            if let error = error {
                print("Error updating workout: \(error)")
            } else {
                print("Workout updated successfully")
                DispatchQueue.main.async {
                    self?.navigationController?.popViewController(animated: true)
                }
                
            }
        }
    }
    
    // UIPickerViewDataSource and UIPickerViewDelegate methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return workouts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return workouts[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedWorkout = workouts[row]
    }
}
