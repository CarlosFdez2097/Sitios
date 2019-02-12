//
//  RegisterController.swift
//  AppDeMapas
//
//  Created by alumnos on 21/1/19.
//  Copyright © 2019 alumnos. All rights reserved.
//

import UIKit
import Alamofire

class RegisterController: UIViewController {
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    var peticion : Int = 0
    var token: Data? = nil
    
    
    @IBAction func registerBtn(_ sender: Any)
    {
        
        if((!(nameTxt.text?.isEmpty)!) && (!(emailTxt.text?.isEmpty)!) && (!(passwordTxt.text?.isEmpty)!) )
        {
            RegisterPetition(name: nameTxt.text!, email: emailTxt.text! , password: passwordTxt.text!)
        }
    }
    
    func RegisterPetition(name:String,email:String,password:String)  {
        
        let url: String = "http://localhost:8888/glober/public/api/register"
        
        let parameters: Parameters = ["user": nameTxt.text!, "email": emailTxt.text!, "password": passwordTxt.text!]
        let _headers : HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
        
        Alamofire.request(url, method: .post, parameters: parameters ,encoding: URLEncoding.httpBody , headers: _headers).responseJSON{
            response in
            
            print(response)
            
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
                self.performSegue(withIdentifier: "register", sender: nil)
            }
        }
    }
}

