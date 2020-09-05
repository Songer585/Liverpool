//
//  ProductosTableViewCell.swift
//  Liverpool
//
//  Created by Jorge Arturo Parra Avila on 04/09/20.
//  Copyright © 2020 Jorge Arturo Parra Avila. All rights reserved.
//

import UIKit

class ProductosTableViewCell: UITableViewCell {
    
    let imageCell : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let titulo: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        lbl.numberOfLines = 3
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let ubicacion: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let precio: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textColor = UIColor.red
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addSubview(imageCell)
        addSubview(titulo)
        addSubview(ubicacion)
        addSubview(precio)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0(150)]-10-[v1]-20-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":   imageCell, "v1": titulo]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0(150)]-10-[v1]-20-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":   imageCell, "v1": ubicacion]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0(150)]-10-[v1]-20-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":   imageCell, "v1": precio]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(150)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":   imageCell]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[v0]-15-[v1]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": titulo, "v1": ubicacion]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(25)]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": precio]))
    }
    
    func commonInit(image: String, title: String, ubica: Bool, subtitle: Float){
        
        let url = URL(string: image)
        let data = try? Data(contentsOf: url!)
        
        imageCell.image = UIImage(data: data!)
        titulo.text = title
        precio.text = "$\(subtitle)"
        
        if ubica{
            ubicacion.text = "En existencia"
        }else {
            ubicacion.text = "No hay disponible por el momento"
        }
    }
}
