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
    var viewModel = SearchViewModel()
    var search: PhotoSearchRequest = PhotoSearchRequest(searchKeyword: "", itemsPerPage: 10, page: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchBar()
        self.setupTable()
        self.registerCells()
        self.enableKeyboardDismiss()
        self.title = self.viewModel.screen.rawValue
    }
    
    func registerTableRefreshEventObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(refresh(_:)), name: NSNotification.Name(UINotificationEvents.refreshTable.rawValue), object: nil)
    }
    
    func registerShowDetailsEventObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(showDetails(notification:)), name: NSNotification.Name(UINotificationEvents.showDetails.rawValue), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.registerTableRefreshEventObserver()
        self.registerErrorEventObserver()
        self.registerShowDetailsEventObserver()
    }

    override func viewDidDisappear(_ animated: Bool) {
        /// remove all observer
        NotificationCenter.default.removeObserver(self)
    }
    
    func registerCells() {
        guard self.tableView != nil else { return }
        let cellIdentifier = PhotoTableViewModel().identifier
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
    func setupSearchBar() {
        guard self.searchBar != nil else { return }
        self.searchBar.delegate = self
    }
    
    func setupTable() {
        guard self.tableView != nil else { return }
        self.tableView.estimatedRowHeight = 1
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.prefetchDataSource = self
    }
    
    @objc func refresh(_: NSNotification) {
        self.tableView.reloadData()
    }
    
    @objc func showDetails(notification: NSNotification) {
        guard let photo = notification.userInfo?[NotificationUserInfoKey.photo.rawValue] as? PhotoResult else { return }
        AppNav.shared.pushToDetails(photo, vc: self)
    }
}

/**
 Handling table delegates
 */
extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching  {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if viewModel.needToLoadMore(indexPath.row) {
                viewModel.next()
                return
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = self.viewModel.getCellViewModel(indexPath.row)
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.identifier, for: indexPath) as! TableViewCell
        cell.viewModel = cellViewModel
        cell.setupUI()
        return cell
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
      let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
      let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
      return Array(indexPathsIntersection)
    }
}

extension SearchViewController: UISearchBarDelegate {
        
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        viewModel.searchReq(text)
    }
}
