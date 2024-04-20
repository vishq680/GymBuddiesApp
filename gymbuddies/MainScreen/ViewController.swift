//
//  ViewController.swift
//  gymbuddies
//
//  Created by Vishaq Jayakumar on 4/15/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {
    
    let mainScreen = MainScreenView()
    
    var usersList = [User]()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    var currentUser:FirebaseAuth.User?
    
    let database = Firestore.firestore()
    
    override func loadView() {
        view = mainScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //MARK: not signed in...
                self.currentUser = nil
                self.mainScreen.labelText.text = "Please sign in!"
                
                
                //MARK: Reset tableView...
                self.usersList.removeAll()
                self.mainScreen.tableViewUsers.reloadData()
                
                //MARK: Sign in bar button...
                self.setupRightBarButton(isLoggedin: false)
                
            }else{
                //MARK: the user is signed in...
                self.currentUser = user
                self.mainScreen.labelText.text = "Welcome \(user?.displayName ?? "Anonymous")!"
                
                
                //MARK: Logout bar button...
                self.setupRightBarButton(isLoggedin: true)
                
                if let currentUser = self.currentUser {
                    // Get the current user's workout preference
                    self.database.collection("users").document(currentUser.uid).getDocument { (document, error) in
                        if let document = document, document.exists {
                            let userData = document.data()
                            if let currentUserWorkout = userData?["workout"] as? String {
                                // Fetch all users with the same workout preference
                                self.database.collection("users").whereField("workout", isEqualTo: currentUserWorkout).getDocuments { (querySnapshot, error) in
                                    if let documents = querySnapshot?.documents {
                                        self.usersList.removeAll()
                                        for document in documents {
                                            do {
                                                let user = try document.data(as: User.self)
                                                // Check if the user's ID is not the current user's ID
                                                if user.id != currentUser.uid {
                                                    self.usersList.append(user)
                                                }
                                            } catch {
                                                print(error)
                                            }
                                        }
                                        self.usersList.sort(by: { $0.name < $1.name })
                                        DispatchQueue.main.async {
                                            self.mainScreen.tableViewUsers.reloadData()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        title = "GYM BUDDIES"
        
        
        //MARK: patching table view delegate and data source...
        mainScreen.tableViewUsers.delegate = self
        mainScreen.tableViewUsers.dataSource = self
        
        //MARK: removing the separator line...
        mainScreen.tableViewUsers.separatorStyle = .none
        
        //MARK: Make the titles look large...
        navigationController?.navigationBar.prefersLargeTitles = true
        setupCustomTitleView()
        
    }
    
    func setupCustomTitleView() {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: navigationController?.navigationBar.frame.height ?? 44))
        
        let titleLabel = UILabel()
        titleLabel.text = "GYM BUDDIES"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30) // Adjust font size as needed
        
        titleView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints to center the title label within the titleView
        NSLayoutConstraint.activate([

            titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor)
        ])
        
        // Set the custom title view to the navigation item
        navigationItem.titleView = titleView
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    
}





