//
//  GuardarViewController.swift
//  Liverpool
//
//  Created by Jorge Arturo Parra Avila on 04/09/20.
//  Copyright © 2020 Jorge Arturo Parra Avila. All rights reserved.
//

import UIKit
import RealmSwift

protocol DataEnteredDelegate {
    func userDidEnterInformation(info: String)
}

class GuardarViewController: UIViewController {

    let tableView: UITableView = {
        let tabla = UITableView()
        tabla.tableFooterView = UIView()
        tabla.translatesAutoresizingMaskIntoConstraints = false
        tabla.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        return tabla
    }()
    
//    var dias = ["Computadora", "Libro", "Blusa", "Refrigerador"]
    
    let realm = try! Realm()
    var busqueda: Results<Busqueda>!
    
    var data:DataEnteredDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        busqueda = realm.objects(Busqueda.self)
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 20)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = "Busquedas"
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .white

        setupLayer()
    }
    
    func setupLayer(){
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    //Comunicamos la respuesta por protocolo
    func busqueda(code: String) {
       self.data?.userDidEnterInformation(info: code)
    }
}

extension GuardarViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busqueda.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.textLabel?.text = busqueda[indexPath.row].titulo
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = busqueda[indexPath.row].titulo
        busqueda(code: data)
        navigationController?.popViewController(animated: true)
    }
}
