//
//  ViewController.swift
//  The_Dog_List
//
//  Created by Maria Tupich on 19/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    private var tableScreen: TableView?
    private var api: DogApiService = DogApiService()
    private var arrayOfDogs: [Response] = []
    
    override func loadView() {
        tableScreen = TableView()
        view = tableScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableScreen?.configTableProtocols(delegate: self, dataSource: self)
        view.backgroundColor = .white
//        self.setNavigationBar()
        fillTableWithApiData()
    }
    
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
        navBar.backgroundColor = .green
        let navItem = UINavigationItem(title: "ALO ALO ALO ")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(done))
        navItem.rightBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }

    @objc func done() { // remove @objc for Swift 3
        print("pronto")
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfDogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let color: [UIColor] = [.orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02, .orange01, .orange02]
        
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.backgroundColor = color[indexPath.row]
        cell.setUpCell(data: self.arrayOfDogs[indexPath.row])
        print(cell.setUpCell(data: self.arrayOfDogs[indexPath.row]))
        print()
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

