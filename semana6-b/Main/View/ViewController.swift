//
//  ViewController.swift
//  semana6-b
//
//  Created by Linder Hassinger on 22/09/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let animeViewModel = AnimeViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        bind()
        setUpTable()
    }
    
    func configure() {
        // se encarga de hacer la peticion
        animeViewModel.getWantedPeople()
    }
    
    func printData() {
        for item in animeViewModel.dataArrayAnimes {
            print(item.title)
        }
    }
    
    func setUpTable() {
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.isEditing = true
//        navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func bind() {
        // se encarga de poder ejecutar la información de manera async
        // aca invoco a refreshData
        animeViewModel.refeshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.printData()
                self?.tableView.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animeViewModel.dataArrayAnimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // ACA VAMOS A SETEAR LA INFORMACION
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let object = animeViewModel.dataArrayAnimes
        
        cell.textLabel!.text? = object[indexPath.row].title
        cell.detailTextLabel?.text = object[indexPath.row].synopsis
        
        // renderizar la foto
        // para esto tengo que convertir la url a un dato tipo data (base64)
        // pas 1 convetir el string a url
        let urlImage = URL(string: object[indexPath.row].image_url)
        // paso 2 conveirto mi url un data
        let data = try? Data(contentsOf: urlImage!)
        
        // paso 3 validar que data no sea null
        if let dataImage = data {
            cell.imageView?.image = UIImage(data: dataImage)
        }
        
        return cell
    }
    
    // reemplazo de editing
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            print(indexPath.row)
            // aca debo el codigo para borrar ese elemento
        } else if editingStyle == .insert {
            print(indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let contextItem = UIContextualAction(style: .normal, title: "Insertar") {  (contextualAction, view, boolValue) in
              //Code I want to do here
        }
        
        let contextItemDelete = UIContextualAction(style: .destructive, title: "Eliminar") {  (contextualAction, view, boolValue) in
              //Code I want to do here
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem, contextItemDelete])

        return swipeActions
    }
    
    
    // reemplazo de moveRowAt
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("movimiento")
    }

}

