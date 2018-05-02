//
//  LoginController.swift
//  gameofchats
//
//  Created by Apple on 4/30/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {

    let inputsContainerView : UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.white
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = 5
    view.layer.masksToBounds = true
        return view
    }()
    
    
    lazy var loginRegisterButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
 
    }()
    
    
    @objc func handleLoginRegister(){
        
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
 
    }
    func handleLogin(){
        
        guard let email = emailTextField.text , let password = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail:email, password: password) { (user, error) in
            if error != nil{
                print(error)
            }
            self.dismiss(animated: true, completion: nil)
        }
        
        
        
    }
    
    @objc func handleRegister(){
        guard let email = emailTextField.text , let password = passwordTextField.text , let name = nameTextField.text
            else
        {   print("Form not valid")
            return
            
        }
        Auth.auth().createUser(withEmail: email  , password: password) { (user, error) in
            // ...
            print(123)
            if error != nil {
                print(error)
                return
            }
            
            
            guard let uid = user?.uid else{ return}
            
           var ref: DatabaseReference!
           ref = Database.database().reference(fromURL: "https://gameofchats-7cf6a.firebaseio.com/")
            let userRef = ref.child("users").child(uid)
            let values = ["name":name,"email":email]
            userRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err)
                    return
                }
                print("Saved user succesfully into Firebase")
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    
    let nameTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
  
        
    }()
    
    let nameSeparatorView: UIView = {
    let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
    return view
    }()
    
    let emailTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email Address"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
        
        
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
        
        
    }()
    
    
    let profileimageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named :"got_splash")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView

    }()

    let loginRegisterSegmentedControl : UISegmentedControl = {
        let sc = UISegmentedControl(items:["Login","Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleSegControl), for: .valueChanged)
        return sc
    }()
    
    
   @objc func handleSegControl(){
    
    let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
    loginRegisterButton.setTitle(title, for: .normal)
    
    inputsContainerViewheightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100: 150
    //change heinght of nametextField
    nametextFieldHeightAnchor?.isActive = false
    nametextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0: 1/3)
    
    nametextFieldHeightAnchor?.isActive = true
    
    
    //
    //change heinght of nametextField
    emailTextFeilfHeight?.isActive = false
    emailTextFeilfHeight = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2: 1/3)
    
    emailTextFeilfHeight?.isActive = true
    
    
    //change heinght of nametextField
    passTextFeilfHeight?.isActive = false
    passTextFeilfHeight = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2: 1/3)
    
    passTextFeilfHeight?.isActive = true
    
    

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(nameTextField)
        view.addSubview(nameSeparatorView)
        view.addSubview(emailTextField)
        view.addSubview(emailSeparatorView)
        view.addSubview(passwordTextField)
        view.addSubview(profileimageView)
        view.addSubview(loginRegisterSegmentedControl)
        setupInputContainerView()
        setupLoginRegisterButton()
        setupProfileImageView()
        setupLoginRegisterSegControl()
        
      
    }

    
    func  setupLoginRegisterSegControl(){
        
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12 ).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
    
    }
    
    var inputsContainerViewheightAnchor :NSLayoutConstraint?
    var nametextFieldHeightAnchor : NSLayoutConstraint?
    var emailTextFeilfHeight : NSLayoutConstraint?
    var passTextFeilfHeight : NSLayoutConstraint?
    
    
    func setupProfileImageView(){
    
        profileimageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileimageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -12 ).isActive = true
        profileimageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileimageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        
    }
    
    
    func setupInputContainerView(){
        
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -24).isActive = true
       inputsContainerViewheightAnchor =  inputsContainerView.heightAnchor.constraint(equalToConstant:150)
       inputsContainerViewheightAnchor?.isActive = true
        
        //nameTextFielf
        
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nametextFieldHeightAnchor =  nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
            
           nametextFieldHeightAnchor?.isActive = true
        
        //nameSeparatorView
        
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //emailTextField
        
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextFeilfHeight = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFeilfHeight?.isActive = true
        
        //nameSeparatorView
        
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //password
        
        //passwordTextField
        
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passTextFeilfHeight =  passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
       passTextFeilfHeight?.isActive = true
 
        
    }
    
    func setupLoginRegisterButton(){
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo:inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        
        
    }
    
    
 
}

extension UIColor {
    
    convenience init( r: CGFloat , g: CGFloat , b : CGFloat){
    self.init(red: r/255   , green : g/255  , blue : b/255 , alpha:1)
    }
    
}
