//
//  ViewController.swift
//  gameofchats
//
//  Created by Apple on 4/30/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Firebase

class MessagesController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title:"LogOut", style: .plain, target: self, action:#selector(handleLogOut))
        let image = UIImage(named:"msg_icon")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Msg", style: .plain, target: self, action: #selector(handleNewMessage))
        checkIfUserIsLoggedIn()
        
      
    }
    
    @objc func handleNewMessage(){
        let newNewMsgController = NewMessageController()
        let navController = UINavigationController(rootViewController: newNewMsgController)
        present(navController, animated: true, completion: nil)
  
    }
    
    func checkIfUserIsLoggedIn(){
        if Auth.auth().currentUser?.uid == nil{
            perform(#selector(handleLogOut), with: nil, afterDelay: 0)
        } else {
            var ref: DatabaseReference!
            ref = Database.database().reference()
            let userID = Auth.auth().currentUser?.uid
            ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                print(snapshot)
                if let value = snapshot.value as? NSDictionary {
              //  let username = value?["name"] as? String ?? ""
                //let user = User(username: name)
                    self.navigationItem.title = value["name"] as? String
                }
                
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }
            
        }
    }
  
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
        
    }

    
    @objc func handleLogOut(){
     
        
        do {
            try Auth.auth().signOut()
        }
        catch let logoutError{
            print(logoutError)
        }
        
        let loginController = LoginController()
      present(loginController, animated:true , completion: nil)
        
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

