//
//  MainViewController + UISearchBar.swift
//  M22_MVVM_Homework
//
//  Created by Sergey Savinkov on 20.02.2024.
//

import UIKit

extension MainViewController: UISearchBarDelegate {
    
    func setupeSearch() {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Введите название фильма"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        if !text.isEmpty {
            self.viewModel.searchFilm(text: text)
            bindViewModel()
        }
    }
}
