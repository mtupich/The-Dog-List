//
//  TableViewCell.swift
//  The_Dog_List
//
//  Created by Maria Tupich on 19/04/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier: String = "TableViewCell"
    
    lazy var dogImageview: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        image.layer.cornerRadius = image.frame.size.width/2
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .purple
        return image
    }()
    
    lazy var dogNameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupTableCellConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.addSubview(dogImageview)
        self.addSubview(dogNameLabel)
    }
    
    func setUpCell(data: Response) {
//        dogImageview.image = UIImage(named: data.image)
        dogNameLabel.text = data.name
    }
    
    func setupTableCellConstraint() {
        NSLayoutConstraint.activate([
        
            dogImageview.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            dogImageview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            dogImageview.heightAnchor.constraint(equalToConstant: 100),
            dogImageview.widthAnchor.constraint(equalToConstant: 100),
            
            dogNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dogNameLabel.leadingAnchor.constraint(equalTo: self.dogImageview.trailingAnchor, constant: 24),
        ])
    }
    
}
