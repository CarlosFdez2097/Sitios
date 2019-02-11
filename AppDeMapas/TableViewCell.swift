//
//  TableViewCell.swift
//  AppDeMapas
//
//  Created by alumnos on 11/2/19.
//  Copyright © 2019 alumnos. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell
{
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Description: UITextField!
    
    var id:Int = 0
    var nombre:String = ""
    var comentario:String = ""
    var fechaDesde:String = ""
    var fechaHasta:String = ""
    var latitud:Double = 0
    var longitud:Double = 0
    
}
