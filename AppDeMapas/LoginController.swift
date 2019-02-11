//
//  Login.swift
//  AppDeMapas
//
//  Created by alumnos on 14/1/19.
//  Copyright © 2019 alumnos. All rights reserved.
//

import UIKit
import Alamofire

class LoginController: UIViewController {
    
    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    var peticion: Int = 0
    
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
           loginPeticion(email: name.text! , password: password.text!)
        }
    }
    
    func loginPeticion(email:String,password:String)
    {
        print(email,password)
        
        let url: String = "http://localhost:8888/glober/public/api/login"
        
        let parameters: Parameters = ["email": email, "password": password]
        let _headers : HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
        
        Alamofire.request(url, method: .post, parameters: parameters ,encoding: URLEncoding.httpBody , headers: _headers).responseJSON
        {
            response in
            
            print(response.result.value! , response.response?.statusCode ?? 0)
            
            self.peticion = (response.response?.statusCode)!
            var Respuesta = response.result.value as! [String:String]
            
            if(response.response?.statusCode != 200)
            {
                print(Respuesta["message"]!)
                print("error")
            }else
            {
                UserDefaults.standard.set(Respuesta["data"]!, forKey: "Token")
                print(Respuesta["message"]!)
                print(Respuesta["data"]!)
                self.performSegue(withIdentifier: "login", sender: nil)
            }
        }
    }
    
}
