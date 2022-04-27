//
//  ViewController.swift
//  The_Dog_List
//
//  Created by Maria Tupich on 19/04/22.
//

import UIKit
import Kingfisher

class MyTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBarController()
    }
    
    private func setupTabBarController() {
        
        let tela01 = UINavigationController(rootViewController: Home())
        let tela02 = UINavigationController(rootViewController: Detail())
        let tela03 = UINavigationController(rootViewController: Favorites())
        self.setViewControllers([tela01, tela02, tela03], animated: false)
        UITabBar.appearance().barTintColor = .black
        self.tabBar.isTranslucent = false
        
        guard let items = tabBar.items else { return }
        
        items[0].title = "Home"
        items[0].image = UIImage(systemName: "house")
        
        items[1].title = "Detail"
        items[1].image = UIImage(systemName: "star")
        
        items[2].title = "Favorites"
        items[2].image = UIImage(systemName: "heart")
    }
}

class Detail: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        self.title = "Detail"
    }
}

class Favorites: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        self.title = "Fav"
    }
}


class Home: UIViewController {
    private var tableScreen: TableView?
    private var api: DogApiService = DogApiService()
    private var arrayOfDogs: [Response] = []
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 350, height: 20))
    
    override func loadView() {
        tableScreen = TableView()
        view = tableScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableScreen?.configTableProtocols(delegate: self, dataSource: self)
        searchBar.placeholder = "Breed"
        var leftNavBarButton = UIBarButtonItem(customView:searchBar)
        leftNavBarButton.tintColor = .red
        navigationItem.titleView = searchBar
        searchBar.searchTextField.backgroundColor = .customBrown
        configNavBar()
        fillTableWithApiData()
    }
    
    @objc func done() { // remove @objc for Swift 3
        print("pronto")
    }
    
    func configNavBar() {
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = .black
        self.navigationItem.standardAppearance = barAppearance
        self.navigationItem.scrollEdgeAppearance = barAppearance
    }
    
    func fillTableWithApiData() {
        api.requestDataFromApi { data in
            switch data {
            case .success(let jsonResult):
                let dogs = jsonResult
                self.arrayOfDogs = Array(dogs[0..<dogs.count])
                DispatchQueue.main.async {
                    self.tableScreen?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension Home: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfDogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let color: [UIColor] = [.orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02]
        
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        let url = arrayOfDogs[indexPath.row].image
        let urlImage = URL(string: url)
        
        cell.backgroundColor = color[indexPath.row]
        cell.setUpCell(data: self.arrayOfDogs[indexPath.row])
        print(cell.setUpCell(data: self.arrayOfDogs[indexPath.row]))
        cell.selectionStyle = .none
        
        cell.dogImageview.kf.setImage(with: urlImage,
                                      placeholder: UIImage(named: "dog"),
                                      options: [ .transition(ImageTransition.fade(2.0))]) { Resultado in
                                        switch Resultado {
                                        case .success(let image):
                                            print(image.cacheType)
                                        case .failure(let error):
                                            print(error.localizedDescription)
                                        }
                                    }
        
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension Home: UITextFieldDelegate {
    
}


