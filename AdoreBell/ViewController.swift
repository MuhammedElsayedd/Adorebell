//
//  ViewController.swift
//  AdoreBell
//
//  Created by Muhammed Elsayed on 3/1/18.
//  Copyright © 2018 Muhammed Elsayed All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import FirebaseAuth

class ViewController: UIViewController {

    var backgroundView:UIView?
    var activityIndicator:NVActivityIndicatorView?
   
   
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    @IBAction func signInButton(_ sender: Any) {
        let frame = CGRect(x: view.frame.width/4, y: view.frame.height/4, width: view.frame.width/2, height: view.frame.height/2)
        backgroundView = UIView()
        backgroundView!.frame.size=view.frame.size
        backgroundView!.backgroundColor=UIColor.black
        backgroundView!.alpha=0.2
        activityIndicator = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.ballClipRotateMultiple,color:UIColor.black)

        view.addSubview(backgroundView!)
        view.addSubview(activityIndicator!)
        activityIndicator?.startAnimating()
        checkUserNameAndPassword()
    }
    
    
    func checkUserNameAndPassword(){
          Auth.auth().signIn(withEmail: userNameTextField.text!, password: passwordTextField.text!) { (user, error) in
            if user != nil{
                self.performSegue(withIdentifier: "signIn", sender: (Any).self)
            }else{
                self.activityIndicator?.stopAnimating()
                self.activityIndicator?.removeFromSuperview()
                self.backgroundView?.removeFromSuperview()
                self.uiAlertController()
            }}
    }

    
    func uiAlertController(){
        let alert = UIAlertController(title: "Error", message: "Invalid Username or Password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

