//
//  ViewController.swift
//  Photoz
//
//  Created by Xuwei Liang on 26/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var search: PhotoSearchRequest = PhotoSearchRequest(searchKeyword: "", itemsPerPage: 10, page: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTable()
        self.registerCells()
    }
    

    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func registerCells() {
        guard self.tableView != nil else { return }
        let nib = UINib(nibName: "searchResultCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "searchResultCell")
    }
    
    func setupTable() {
        guard self.tableView != nil else { return }
        self.tableView.estimatedRowHeight = 1
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

/**
 Handling table delegates
 */
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension SearchViewController: UISearchBarDelegate {
        
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
}
