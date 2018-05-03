//
//  NewMessageController.swift
//  gameofchats
//
//  Created by Apple on 5/1/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {
    
    var users = [User]()
    
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"Cancel", style: .plain, target: self, action:#selector(handleCancel))
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        fetchUser()
  
        
    }
    
    func fetchUser(){
        
        var ref: DatabaseReference!
        ref = Database.database().reference().child("users")
        ref.observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String:AnyObject] {
                let user = User()
                user.name = (dictionary["name"] as? String)!
                user.email = (dictionary["email"] as? String)!
             //   print(dictionary["profileImageUrl"])
                user.profileImageUrl = (dictionary["profileImageUrl"] as? String)
                self.users.append(user)
               
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                
           }
        }, withCancel: nil)
       
    }
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:cellId, for: indexPath)
        let user  = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        cell.imageView?.image = UIImage(named:"got_splash")
       
        
        
        if let profileImageUrl = user.profileImageUrl {
            let ProfileURL = URL(string: profileImageUrl)
            URLSession.shared.dataTask(with: ProfileURL!, completionHandler: { (data, response, err) in
                if(err != nil){
                    print(err)
                }
                DispatchQueue.main.async {
                    cell.imageView?.image = UIImage(data: data!)
                }
                
                
                
            }).resume()
        
        }
       
 
        return cell
    }

    
 
}

class UserCell : UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
