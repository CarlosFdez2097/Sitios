//
//  AnadirViewController.swift
//  AppDeMapas
//
//  Created by alumnos on 28/1/19.
//  Copyright © 2019 alumnos. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire


class AnadirViewController: UIViewController , CLLocationManagerDelegate ,MKMapViewDelegate{
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var description1: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var dateStart: UIDatePicker!
    @IBOutlet weak var dateEnd: UIDatePicker!
    
    let locationManager = CLLocationManager()
    var peticion: Int = 0
    var newCoords = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(action(gestureRecognizer:)))
        mapView.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.layoutIfNeeded()
        self.viewDidLoad()
    }
    
    
    @IBAction func Add(_ sender: UIButton) {
        
        if(!(name.text?.isEmpty)! && !(description1.text?.isEmpty)!)
        {
            if(newCoords.latitude != 0 && newCoords.longitude != 0)
            {
                    crearLugar()
            }else
            {
                let alert = UIAlertController(title: "Por favor pon la ubacion en el mapa ", message: "Por favor pon la ubacion en el mapa ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            } 
        }else
        {
            let alert = UIAlertController(title: "Todos los campos deben estar rellenos", message: "Nada puede estar vacio", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func crearLugar(){
        
        let start = formarFecha(date: dateStart.date)
        let end = formarFecha(date: dateEnd.date)
        
        let url: String = "http://localhost:8888/glober/public/api/spot"
        let token = UserDefaults.standard.string(forKey: "Token")
        
        let parameters: Parameters = ["spotName": name.text!, "spotDescription": description1.text!, "dateOfStart": start, "dateOfEnd": end,"coordenadasX": newCoords.latitude, "coordenadasY": newCoords.longitude]
        let _headers: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded", "Authorization": token!]
        print(parameters)
        
        Alamofire.request(url, method: .post, parameters: parameters ,encoding: URLEncoding.httpBody , headers: _headers).responseJSON{
            response in
            
            self.peticion = (response.response?.statusCode)!
            
            var Respuesta = response.result.value as! [String:String]
            
            
            if(response.response?.statusCode != 200)
            {
                let alert = UIAlertController(title: "Por favor pon la ubacion en el mapa ", message: "Por favor pon la ubacion en el mapa ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                print(Respuesta["message"]!)
                print("error")
            }else
            {
                let alert = UIAlertController(title: "Lugar creado ", message: "Puedes volver a crear otro lugar", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                self.name.text = " "
                self.description1.text = " "
                self.dateStart.setDate(Date.init(), animated: true)
                self.dateEnd.setDate(Date.init(), animated: true)
                self.mapView.removeAnnotations(self.mapView.annotations)
                
                
                UserDefaults.standard.set(Respuesta["data"]!, forKey: "message")
                print(Respuesta["message"]!)
                print(Respuesta["data"]!)
            }
        }
    }
   
    
    func formarFecha(date: Date) -> String {
        
        let dataformer = DateFormatter()
        dataformer.locale = Locale(identifier: "en_US_POSIX")
        dataformer.dateFormat = "yyyy/MM/dd"
        
        let finalDate : String = dataformer.string(from: date)
        
        return finalDate
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
        annotationView.image = UIImage(named:"pin")
        annotationView.canShowCallout = true
        
        return annotationView
    }
    
    @objc func action(gestureRecognizer: UIGestureRecognizer) {
        
        self.mapView.removeAnnotations(mapView.annotations)
        
        let touchPoint = gestureRecognizer.location(in: mapView)
        newCoords = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = newCoords
        mapView.addAnnotation(annotation)
        print(newCoords)
    }
}
