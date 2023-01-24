//
//  FavoritesView.swift
//  GameProject
//
//  Created by emre can duygulu on 25.01.2023.
//

import UIKit

class FavoritesView: UIView {
    
    lazy var tableView: UITableView = {
        let tView = UITableView(frame: .zero, style: .plain)
        tView.estimatedRowHeight = 100
        tView.register(CellView.self, forCellReuseIdentifier: CellView.cellId)
        tView.separatorColor = .darkTeal
        tView.separatorInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tView.tableFooterView = UIView()
        tView.translatesAutoresizingMaskIntoConstraints = false
        return tView
    }()
    
    init() {
        super.init(frame: .zero)
        
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
