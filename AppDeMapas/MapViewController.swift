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
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        self.mapView.delegate = self
        
        
        let coordenadasOrigen = CLLocationCoordinate2DMake(0, 0)
        let pin = Pin(pinId: 0 ,pinTitle: "sdfdf" , pinSubTitle: "i.comentario", location: coordenadasOrigen)
        self.mapView.addAnnotation(pin)
    }
    override func viewWillAppear(_ animated: Bool) {
        mostrarLugares()
        self.view.layoutIfNeeded()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mostrarLugares()
    }
    

    func mostrarLugares(){

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
                
                let alert = UIAlertController(title: Respuesta as! String, message: Respuesta as! String, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }else
            {
                var Respuesta = response.result.value as! [String:Any]
                
                var sitios = Respuesta["data"] as! [[String:Any]]
                
                let numeroLugares = sitios.count
                
                print(sitios.count)
                
                for i in 0...numeroLugares-1
                {
                    self.mapView.removeAnnotations(self.mapView.annotations)
                    
                    Spots.append(Spot(id: sitios[i]["id"] as! Int, nombre: sitios[i]["name"] as! String, comentario: sitios[i]["description"] as! String, fechaDesde: sitios[i]["dateOfStart"] as! String, fechaHasta: sitios[i]["dateOfEnd"] as! String, latitud: sitios[i]["coordenadasX"] as! Double , longitud: sitios[i]["coordenadasY"] as! Double))
                }
                
                
                for i in Spots
                {
                    let coordenadasOrigen = CLLocationCoordinate2DMake(i.latitud, i.longitud)
                    print(coordenadasOrigen)
                    let pin = Pin(pinId: i.id ,pinTitle: i.nombre, pinSubTitle: i.comentario, location: coordenadasOrigen)
                    self.mapView.addAnnotation(pin)
                    
                }
            }
        }
    }
}

extension MapViewController
{
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
       // view.annotation?.title
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
        annotationView.image = UIImage(named:"recurso7")
        annotationView.canShowCallout = true
        return annotationView
    }
}
