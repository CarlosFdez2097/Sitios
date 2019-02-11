//
//  File.swift
//  AppDeMapas
//
//  Created by alumnos on 11/2/19.
//  Copyright © 2019 alumnos. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class File: UIViewController,CLLocationManagerDelegate
{
    
    @IBOutlet weak var mapa: MKMapView!

    override func viewDidLoad()
    {
        let coordenadasOrigen = CLLocationCoordinate2DMake(0, 0)
        
        let anotacion = MKPointAnnotation()
        
        anotacion.coordinate = coordenadasOrigen
        anotacion.title = "i.nombre"
        
        
        self.mapa.addAnnotation(anotacion)
    }
    
}
