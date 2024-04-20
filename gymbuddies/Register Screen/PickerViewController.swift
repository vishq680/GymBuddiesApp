//
//  PickerViewController.swift
//  gymbuddies
//
//  Created by Vishaq Jayakumar on 4/17/24.
//

import UIKit

extension RegisterViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // Replace with your list of workouts
        return ["Chest", "Triceps", "Biceps", "Back", "Legs", "Shoulder", "Abs"].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // Replace with your list of workouts
        let workouts = ["Chest", "Triceps", "Biceps", "Back", "Legs", "Shoulder", "Abs"]
        return workouts[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Replace with your list of workouts
        let workouts = ["Chest", "Triceps", "Biceps", "Back", "Legs", "Shoulder", "Abs"]
        selectedWorkout = workouts[row]
    }
}
