//
//  UITableView.swift
//  AppDeMapas
//
//  Created by alumnos on 11/2/19.
//  Copyright © 2019 alumnos. All rights reserved.
//

import UIKit
import Alamofire

class TableViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    var peticion: Int = 0
    var position = 0
    @IBOutlet weak var tabla: UITableView!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tabla.delegate = self
        self.tabla.dataSource = self
        self.tabla.rowHeight = 120
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        Spots = []
        self.position = 0
        mostrarLugares()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Spots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let celda = tableView.dequeueReusableCell(withIdentifier: "SitiosCelda", for: indexPath) as! TableViewCell
        
        if(self.position < Spots.count)
        {
            celda.Name.text = Spots[self.position].nombre
            celda.Description.text = Spots[self.position].comentario
            self.position += 1
        }
        return celda
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        spotSelected = Spots[indexPath.row]
    }
    
    func mostrarLugares()
    {
        let url: String = "http://localhost:8888/glober/public/index.php/api/spot"
        let token = UserDefaults.standard.string(forKey: "Token")
        
        let _headers: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded", "Authorization": token!]
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.httpBody, headers: _headers).responseJSON{
            response in
            
            self.peticion = (response.response?.statusCode)!
            
            if(response.response?.statusCode != 200)
            {
                let Respuesta = response.result.value as! [String:String]
                print(Respuesta)
                
                let alert = UIAlertController(title: Respuesta as? String, message: Respuesta as? String, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }else
            {
                var Respuesta = response.result.value as! [String:Any]
                
                var sitios = Respuesta["data"] as! [[String:Any]]
                
                let numeroLugares = sitios.count
                
                for i in 0...numeroLugares-1
                {
                    Spots.append(Spot(id: sitios[i]["id"] as! Int, nombre: sitios[i]["name"] as! String, comentario: sitios[i]["description"] as! String, fechaDesde: sitios[i]["dateOfStart"] as! String, fechaHasta: sitios[i]["dateOfEnd"] as! String, latitud: sitios[i]["coordenadasX"] as! Double , longitud: sitios[i]["coordenadasY"] as! Double))
                }
                print(Spots)
                self.position = 0
                self.tabla.reloadData()
            }
        }
    }
}
