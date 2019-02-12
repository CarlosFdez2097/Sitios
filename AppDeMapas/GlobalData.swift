//
//  GlobalData.swift
//  AppDeMapas
//
//  Created by alumnos on 28/1/19.
//  Copyright © 2019 alumnos. All rights reserved.
//

import Foundation
import Alamofire

//Donde almaceno los datos de las ubicaciones
var titulos = [String]()
var comentarios = [String]()
var fechaDesde = [String]()
var fechaHasta = [String]()
//Coordenadas de las ubicaciones creadas
var coordenadasA:[Double] = [2.1]
var coordenadasB:[Double] = [1.2]
//Son arrays en los que meto la info que me devuelve la base de datos
var Spots:[Spot] = []
//
var spotSelected:Spot!
