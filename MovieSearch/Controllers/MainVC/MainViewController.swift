//
//  ViewController.swift
//  MovieSearch
//
//  Created by Sergey Savinkov on 27.02.2024.
//

import UIKit

class MainViewController: UIViewController {
    //ViewModel
    var viewModel: MainViewModel = MainViewModel()
    //Variables
    var moviesDataSoure: [MovieTableViewCellModel] = []
    
    let resultTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 180
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupeSearch()
        bindViewModel()
        setupTableView()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(spinner)
        view.addSubview(resultTableView)
    }
    
    func bindViewModel() {
        viewModel.isLoadingDate.bind { [weak self] isLoading in
            guard let isLoading = isLoading else { return }
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if isLoading {
                    self.resultTableView.isHidden = true
                    self.spinner.startAnimating()
                } else {
                    self.resultTableView.isHidden = false
                    self.spinner.stopAnimating()
                }
            }
        }
        viewModel.movies.bind { [weak self] movies in
            guard let self = self,
                  let movies = movies else { return }
            
            self.moviesDataSoure = movies
            self.resultTableView.reloadData()
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            resultTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            resultTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            resultTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            resultTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10)
        ])
    }
}

