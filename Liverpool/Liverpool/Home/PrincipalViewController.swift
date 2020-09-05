//
//  ViewController.swift
//  Liverpool
//
//  Created by Jorge Arturo Parra Avila on 04/09/20.
//  Copyright © 2020 Jorge Arturo Parra Avila. All rights reserved.
//

import UIKit

class PrincipalViewController: UIViewController {
    
    let tableView: UITableView = {
        let tabla = UITableView()
        tabla.tableFooterView = UIView()
        tabla.translatesAutoresizingMaskIntoConstraints = false
        return tabla
    }()
    
    let myActivityIndicator: UIActivityIndicatorView = {
        let act = UIActivityIndicatorView()
        act.hidesWhenStopped = true
        act.style = UIActivityIndicatorView.Style.large
        act.color = UIColor.lightGray
        act.translatesAutoresizingMaskIntoConstraints = false
        return act
    }()
    
    var refresher = UIRefreshControl()
    let searchController = UISearchController(searchResultsController: nil)
    
    var dataAll: Productos? = nil
    var productos = [Records]()
    
    var busquedaItem: String = ""
    var numeroItem: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Liverpool")
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 20)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        navigationItem.title = "Liverpool"
        
    
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar en Liverpool..."
        
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        let nibTest = UINib(nibName: "ProductosTableViewCell", bundle: nil)
        tableView.register(nibTest, forCellReuseIdentifier: "cellProducts")
        
        refresher.attributedTitle = NSAttributedString(string: "Actualizando")
        refresher.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        
        setupLayer()
    }

    func setupLayer(){
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(myActivityIndicator)
        myActivityIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        myActivityIndicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
        myActivityIndicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
        myActivityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        tableView.addSubview(refresher)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.reloadData()
    }
    
    @objc func refreshAction(_ sender: Any) {
        tableView.reloadData()
        
    }
    
    //Consumo del API
    func jsonDatos(busqueda: String, numero: Int){
        
        let url = URL(string: "https://shoppapp.liverpool.com.mx/appclienteservices/services/v3/plp?force-plp=true&search-string=\(busqueda)&page-number=1&number-of-items-per-page=\(numero)")

        guard let dowloadURL = url else { return }
        
        let task = URLSession.shared.dataTask( with: dowloadURL, completionHandler: { (data, urlResponse, error) in
            
            guard let data = data, error == nil, urlResponse != nil else {
                print("Algo salio mal")
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let data = try decoder.decode(Productos.self, from: data)
                DispatchQueue.main.async {
                    self.dataAll = data
                    self.productos = self.dataAll?.plpResults?.records ?? []
                    self.tableView.reloadData()
                }
            } catch {
                print("Algo salio mal despues de la descarga")
            }
        }
        )
        task.resume()
    }
}

//Manejo del SearchController
extension PrincipalViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive{
            busquedaItem = searchController.searchBar.text!.capitalized
            jsonDatos(busqueda: searchController.searchBar.text!.capitalized, numero: numeroItem)
            tableView.reloadData()
        }else {
            busquedaItem = ""
            numeroItem = 10
            tableView.reloadData()
        }
    }
    
}

extension PrincipalViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellProducts", for: indexPath) as! ProductosTableViewCell
        
        //Muesta el objeto llenado del json
        let datos = productos[indexPath.row]
        cell.commonInit(image: datos.smImage!, title: datos.productDisplayName!, ubica: datos.isMarketPlace! ,subtitle: datos.listPrice!)
        return cell
    }
    
////    //Dimension de las celdas
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            numeroItem = numeroItem + 10
            jsonDatos(busqueda: busquedaItem, numero: numeroItem)
        }
    }
}
