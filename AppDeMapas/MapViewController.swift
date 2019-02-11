//
//  MapViewController.swift
//  AppDeMapas
//
//  Created by alumnos on 28/1/19.
//  Copyright © 2019 alumnos. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Alamofire
import CoreLocation

class MapViewController: UIViewController ,CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var peticion: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let coordenadasOrigen = CLLocationCoordinate2DMake(0, 0)
        
        var anotacion = MKPointAnnotation()
        
        anotacion.coordinate = coordenadasOrigen
        anotacion.title = "i.nombre"
        
        
        self.mapView.addAnnotation(anotacion)
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        mostrarLugares()
        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        manager.startUpdatingLocation()
    }
    

    

    func mostrarLugares(){

        let url: String = "http://localhost:8888/glober/public/index.php/api/spot"
        let token = UserDefaults.standard.string(forKey: "Token")
        
        let _headers: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded", "Authorization": token!]
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.httpBody, headers: _headers).responseJSON{
            response in
            
            self.peticion = (response.response?.statusCode)!
            Spots = []
            if(response.response?.statusCode != 200)
            {
                let Respuesta = response.result.value as! [String:String]
                print(Respuesta)
                
                let alert = UIAlertController(title: Respuesta as! String, message: Respuesta as! String, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }else
            {
                var Respuesta = response.result.value as! [String:Any]
                
                var sitios = Respuesta["data"] as! [[String:Any]]
                
                let numeroLugares = sitios.count
                
                print("sitios ", sitios.count)
                
                //self.mapView.removeAnnotations(self.mapView.annotations)
                
                for i in 0...numeroLugares-1
                {
                    
                    Spots.append(Spot(id: sitios[i]["id"] as! Int, nombre: sitios[i]["name"] as! String, comentario: sitios[i]["description"] as! String, fechaDesde: sitios[i]["dateOfStart"] as! String, fechaHasta: sitios[i]["dateOfEnd"] as! String, latitud: sitios[i]["coordenadasX"] as! Double , longitud: sitios[i]["coordenadasY"] as! Double))
                }
                
                
                for i in Spots
                {
                    let coordenadasOrigen = CLLocationCoordinate2D(latitude: i.latitud, longitude: i.longitud)
                    //let pin = Pin(pinId: i.id ,pinTitle: i.nombre, pinSubTitle: i.comentario, location: coordenadasOrigen)
                    var anotacion = MKPointAnnotation()
                    
                    anotacion.coordinate = coordenadasOrigen
                    anotacion.title = i.nombre
        
                    
                    self.mapView.addAnnotation(anotacion)

                }
                print("pins", self.mapView.annotations.count)

            }
        }
    }
   func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("sjndfgsudfgsijdgfs")
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
        annotationView.image = UIImage(named:"pin")
        annotationView.canShowCallout = true
        
        return annotationView
    }
}


