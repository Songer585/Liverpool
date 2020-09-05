//
//  BusquedaReciente.swift
//  Liverpool
//
//  Created by Jorge Arturo Parra Avila on 04/09/20.
//  Copyright © 2020 Jorge Arturo Parra Avila. All rights reserved.
//

import UIKit
import RealmSwift

class Busqueda: Object {
//Venues
    @objc dynamic var titulo = ""
    
    override static func primaryKey() -> String? {
        return "titulo"
    }
}
