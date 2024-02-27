//
//  MainViewModel.swift
//  MovieSearch
//
//  Created by Sergey Savinkov on 27.02.2024.
//

import Foundation

class MainViewModel {
    
    var isLoadingDate: Observable<Bool> = Observable(false)
    var dataSource: MovieModel?
    var movies: Observable<[MovieTableViewCellModel]> = Observable(nil)
    
    func numberOfRows(in section: Int) -> Int {
        return dataSource?.films.count ?? 0
    }
    
    func searchFilm(text: String) {
        isLoadingDate.value = true
      
        if text.count != 0 {
            ServiceManager.shared.searchKeywordFilm(with: text) { [weak self] result in
                guard let self = self else { return }
                self.isLoadingDate.value = false
                switch result {
                case .success(let film):
                    DispatchQueue.main.async {
                        self.movies.value?.removeAll()
                        self.dataSource = nil
                        self.dataSource = film
                        self.mapCompact()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        } else {
                self.isLoadingDate.value = false
            }
        }
    
    func getData() {
        self.isLoadingDate.value = true
        
        ServiceManager.shared.getTopFilms { [weak self] result in
            guard let self = self else { return }
            self.isLoadingDate.value = false
            
            switch result {
            case .success(let film):
                DispatchQueue.main.async {
                    self.dataSource = film
                    self.mapCompact()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func mapCompact() {
        movies.value = self.dataSource?.films.compactMap({MovieTableViewCellModel(movie: $0)})
    }
}
