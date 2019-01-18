//
//  Login.swift
//  AppDeMapas
//
//  Created by alumnos on 14/1/19.
//  Copyright © 2019 alumnos. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: UIButton){
        
        if((!(name.text?.isEmpty)!) && (!(name.text?.isEmpty)!))
        {
            if(loginPeticion(email: name.text! , password: password.text!))
            {
                performSegue(withIdentifier: "login", sender: nil)
            }
        }
        
    }
    
    func loginPeticion(email:String,password:String) -> Bool {
        return true
    }
    
}
