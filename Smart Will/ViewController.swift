//
//  ViewController.swift
//  Smart Will
//
//  Created by Aeman Jamali on 3/3/18.
//  Copyright © 2018 4slash. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    // All outlets
    @IBOutlet weak var emailTxtb: UITextField!
    @IBOutlet weak var passwordTxtb: UITextField!
    
    // All Actions
    @IBAction func signinBtn(_ sender: Any) {
        // To give up first responder of all text boxes in view.
        view.endEditing(true);
        let loginObj = loginModel();
        let code = loginObj.login(email: emailTxtb.text!, password: passwordTxtb.text!)
        
        login(code: code);
        
        print(code)
        
        
        
    }
    
    
    func login(code: Int){
        if code < 0{
            if code == -2{
                let alert = UIAlertController(title: "Error!", message: "Login Failed. \n Invalid Credentials!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else if code == -1{
                let alert = UIAlertController(title: "Error!", message: "Login Failed. \n Can't connect to server!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else{
            // code is id of user here.
        }
        
    }
    
    
    // Give up first responder of all text fields when touching background or away from txtboxes
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true);
    }
    
    // Make this swift class delegate of both txtboxes to remove first responder when pressing return button
    // Add protocol when defining class for UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            passwordTxtb.becomeFirstResponder()
        case 1:
            let loginObj = loginModel();
            _ = loginObj.login(email: emailTxtb.text!, password: passwordTxtb.text!);
        default:
            view.endEditing(true);
        }
        return false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        emailTxtb.tag = 0;
        passwordTxtb.tag = 1;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

