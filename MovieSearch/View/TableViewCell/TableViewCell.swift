//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Sergey Savinkov on 27.02.2024.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static var identifier: String {
        get {
            "MovieTableViewCell"
        }
    }
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel = UILabel(
        text: "",
        font: .boldSystemFont(ofSize: 20),
        color: .black,
        line: 2)
    
    private let realNameLabel = UILabel(
        text: "",
        font: .boldSystemFont(ofSize: 16),
        color: .gray,
        line: 2)
    
    private var nameStackView = UIStackView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        realNameLabel.text = nil
        nameLabel.text = nil
        posterImageView.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        backgroundColor = .clear
        setupStackView()
        
        addSubview(posterImageView)
        addSubview(nameStackView)
    }
    
    private func setupStackView() {
        nameStackView = UIStackView(
            addArrangedSubview: [nameLabel, realNameLabel],
            axis: .vertical,
            spacing: 2,
            aligment: .center,
            destribution: .equalCentering)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            posterImageView.widthAnchor.constraint(equalToConstant: frame.width / 2.5),
            
            nameStackView.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor),
            nameStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 5),
            nameStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            nameStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupCell(viewModel: MovieTableViewCellModel) {
        nameLabel.text = viewModel.nameRu
        realNameLabel.text = viewModel.nameEn
        
        let urlString = viewModel.posterUrl
        guard let url = URL(string: urlString) else { return }
        
        getImage(url: url)
    }
    
    private func getImage(url: URL) {
        ServiceManager.shared.requestImage(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                let image = UIImage(data: data)
                self.posterImageView.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
