//
//  ViewController.swift
//  gameofchats
//
//  Created by Apple on 4/30/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title:"LogOut", style: .plain, target: self, action:#selector(handleLogOut))
        
        if Auth.auth().currentUser?.uid == nil{
            perform(#selector(handleLogOut), with: nil, afterDelay: 0)
            
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

