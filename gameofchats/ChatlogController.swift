//
//  ChatlogController.swift
//  gameofchats
//
//  Created by Apple on 5/4/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Firebase

class ChatlogController: UICollectionViewController,UITextFieldDelegate {
    
    lazy var inputTextField : UITextField = {
     let  textField = UITextField()
    textField.placeholder = "Enter message..."
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.delegate = self
 //   textField.addSubview(inputTextField)
  //      textField.addTarget(self , action: #selector(handlesendButton), for:.)
        
        return textField
   }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Chat log Controller"
        collectionView?.backgroundColor = UIColor.white
        setupInputComponents()
    }

    func   setupInputComponents(){
        let containView = UIView()
        containView.backgroundColor = UIColor.white
        containView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containView)
        
        
        //iOS9 contraint.
        containView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        containView.addSubview(sendButton)
        sendButton.addTarget(self , action: #selector(handlesendButton), for: .touchUpInside)
        
        sendButton.rightAnchor.constraint(equalTo:containView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containView.heightAnchor).isActive = true
        
       
        containView.addSubview(inputTextField)
        inputTextField.leftAnchor.constraint(equalTo: containView.leftAnchor, constant:8).isActive = true
        inputTextField.centerYAnchor.constraint(equalTo: containView.centerYAnchor).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: containView.heightAnchor).isActive = true
        
        let seperatorLineView = UIView()
        seperatorLineView.backgroundColor = UIColor.black
        seperatorLineView.translatesAutoresizingMaskIntoConstraints = false
        containView.addSubview(seperatorLineView)
        
        seperatorLineView.leftAnchor.constraint(equalTo: containView.leftAnchor).isActive = true
        seperatorLineView.topAnchor.constraint(equalTo: containView.topAnchor).isActive = true
        seperatorLineView.widthAnchor.constraint(equalTo: containView.widthAnchor).isActive = true
        seperatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        
        
    }
    
    @objc func handlesendButton(){
        let ref = Database.database().reference().child("messages")
        let childref = ref.childByAutoId()
        let values = ["text":inputTextField.text!]
        childref.updateChildValues(values)
   
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handlesendButton()
        return true
    }
    
    
}
