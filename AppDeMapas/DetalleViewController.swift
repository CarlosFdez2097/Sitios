//
//  DetalleViewController.swift
//  AppDeMapas
//
//  Created by alumnos on 12/2/19.
//  Copyright © 2019 alumnos. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class DetalleViewController: UIViewController, MKMapViewDelegate  {
    
    @IBOutlet weak var mapa: MKMapView!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var descripcion: UILabel!
    @IBOutlet weak var start: UILabel!
    @IBOutlet weak var finish: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapa.delegate = self
        nombre.text = spotSelected.nombre
        descripcion.text = spotSelected.comentario
        start.text = spotSelected.fechaDesde
        finish.text = spotSelected.fechaHasta
        
        let coordenadasOrigen = CLLocationCoordinate2D(latitude: spotSelected.latitud, longitude: spotSelected.longitud)
        self.mapa.setCenter(coordenadasOrigen, animated: true)
        let pin = Pin(pinId: spotSelected.id ,pinTitle: spotSelected.nombre, pinSubTitle: spotSelected.comentario, location: coordenadasOrigen)
        self.mapa.addAnnotation(pin)
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

    
}
