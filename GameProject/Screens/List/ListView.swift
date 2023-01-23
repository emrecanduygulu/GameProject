//
//  ListView.swift
//  GameProject
//
//  Created by emre can duygulu on 18.01.2023.
//

import UIKit

class ListView: UIView {
    
    lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    
    lazy var searchBar: UISearchBar = {
        let sBar = UISearchBar()
        sBar.placeholder = "Search a game..."
        sBar.translatesAutoresizingMaskIntoConstraints = false
        return sBar
    }()
    
    lazy var filterAndOrder: UIView = {
       let fAndO = UIView()
        fAndO.clipsToBounds = true
        fAndO.backgroundColor = .darkTeal
        fAndO.translatesAutoresizingMaskIntoConstraints = false
        
        return fAndO
    }()
    
    lazy var filterButton: UIButton = {
       let fButton = UIButton()
        fButton.setTitle("Filter", for: .normal)
        fButton.setImage(UIImage(systemName: "slider.vertical.3"), for: .normal)
        fButton.tintColor = .white
        fButton.translatesAutoresizingMaskIntoConstraints = false
        return fButton
    }()
    
    lazy var orderButton: UIButton = {
       let oButton = UIButton()
        oButton.setTitle("Order by", for: .normal)
        oButton.setImage(UIImage(systemName: "chevron.down.circle.fill"), for: .normal)
        oButton.tintColor = .white
        oButton.translatesAutoresizingMaskIntoConstraints = false
        return oButton
    }()
    
    lazy var HStack: UIStackView = {
       let HStackView = UIStackView(arrangedSubviews: [
       filterButton,
       orderButton
       ])
        HStackView.axis = .horizontal
        HStackView.spacing = 40
        HStackView.alignment = .fill
        HStackView.distribution = .fillEqually
        HStackView.translatesAutoresizingMaskIntoConstraints = false
        return HStackView
    }()
    
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
        
        addSubview(searchBar)
        addSubview(filterAndOrder)
        filterAndOrder.addSubview(HStack)
        addSubview(tableView)
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            filterAndOrder.heightAnchor.constraint(equalToConstant: 40),
            filterAndOrder.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            filterAndOrder.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            filterAndOrder.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            HStack.centerXAnchor.constraint(equalTo: filterAndOrder.centerXAnchor),
            HStack.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            HStack.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            tableView.topAnchor.constraint(equalTo: filterAndOrder.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
        filterAndOrder.layer.cornerRadius = 10
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
