//
//  Spot.swift
//  AppDeMapas
//
//  Created by alumnos on 28/1/19.
//  Copyright © 2019 alumnos. All rights reserved.
//

import Foundation

class Spot{
    
    var id:Int = 0
    var nombre:String = ""
    var comentario:String = ""
    var fechaDesde:String = ""
    var fechaHasta:String = ""
    var latitud:Double = 0
    var longitud:Double = 0
    
    init(id:Int,nombre:String,comentario:String,fechaDesde:String,fechaHasta:String,latitud:Double,longitud:Double)
    {
        self.id = id
        self.nombre = nombre
        self.comentario = comentario
        self.fechaDesde = fechaDesde
        self.fechaHasta = fechaHasta
        self.latitud = latitud
        self.longitud = longitud
    }
}
