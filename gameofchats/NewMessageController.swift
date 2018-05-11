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
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:cellId, for: indexPath) as? UserCell
        let user  = users[indexPath.row]
        cell?.textLabel?.text = user.name
        cell?.detailTextLabel?.text = user.email
        
        if let profileImageUrl = user.profileImageUrl {
            cell?.profileImagevIew.loadImageUsingCacheWithStringUrl(urlString: profileImageUrl)
            
        }
        
 
        return cell!
    }

   override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let layout = UICollectionViewFlowLayout()
    let chatlogController = ChatlogController(collectionViewLayout: layout)
//    let chatlogController = ChatlogController()
    let chatlogNavigationController = UINavigationController(rootViewController: chatlogController)
  present(chatlogNavigationController, animated: true, completion: nil)

    }
    
 
}

class UserCell : UITableViewCell {
    
    let profileImagevIew : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"got_splash")
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.frame = CGRect(x: 64 , y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        detailTextLabel?.frame = CGRect(x: 64 , y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
        
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier )
        
        addSubview(profileImagevIew)
        // iOS 9 constraint
        profileImagevIew.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImagevIew.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImagevIew.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileImagevIew.heightAnchor.constraint(equalToConstant: 50).isActive = true
 
}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
}
