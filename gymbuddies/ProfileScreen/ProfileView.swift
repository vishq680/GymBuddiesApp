//
//  ProfileView.swift
//  gymbuddies
//
//  Created by Vishaq Jayakumar on 4/18/24.
//


import UIKit

class ProfileView: UIView {
    var labelEmail: UILabel!
    var labelName: UILabel!
    var pickerViewWorkout: UIPickerView!
    var buttonUpdateWorkout: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupLabelEmail()
        setupLabelName()
        setupPickerViewWorkout()
        setupButtonUpdateWorkout()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabelEmail() {
        labelEmail = UILabel()
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEmail)
    }
    
    private func setupLabelName() {
        labelName = UILabel()
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }
    
    private func setupPickerViewWorkout() {
        pickerViewWorkout = UIPickerView()
        pickerViewWorkout.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pickerViewWorkout)
    }
    
    private func setupButtonUpdateWorkout() {
        buttonUpdateWorkout = UIButton(type: .system)
        buttonUpdateWorkout.setTitle("Update Workout", for: .normal)
        buttonUpdateWorkout.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonUpdateWorkout)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            labelName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            labelName.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 16),
            labelEmail.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            labelEmail.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
            pickerViewWorkout.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 16),
            pickerViewWorkout.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            pickerViewWorkout.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
            
            buttonUpdateWorkout.topAnchor.constraint(equalTo: pickerViewWorkout.bottomAnchor, constant: 32),
            buttonUpdateWorkout.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
}
