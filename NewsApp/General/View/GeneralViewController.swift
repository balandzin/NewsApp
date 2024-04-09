//
//  GeneralViewController.swift
//  NewsApp
//
//  Created by Антон Баландин on 21.03.24.
//

import UIKit
import SnapKit

final class GeneralViewController: UIViewController {
    
    // MARK: - GUI Variables
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        //layout.scrollDirection = .horizontal
        
        let width = (view.frame.width - 15) / 2
        
        layout.itemSize = CGSize(width: width, height: width)
        let collectionView = UICollectionView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.frame.width,
                height: view.frame.height - searchBar.frame.height
            ),
            collectionViewLayout: layout
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - Properties
    private var viewModel: NewsListViewModelProtocol
    
    // MARK: - Lifecycle
    init(viewModel: NewsListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.setupViewModel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        collectionView.register(GeneralCollectionViewCell.self, forCellWithReuseIdentifier: "GeneralCollectionViewCell")
        
        viewModel.loadData(searchText: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Methods
    private func setupViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel.reloadCell = { [weak self] indexPath in
            self?.collectionView.reloadItems(at: [indexPath])
        }
        
        viewModel.showError = { [weak self] error in
            print(error)
        }
    }
 
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Methods
    @objc func dismissKeyboard() {
            view.endEditing(true)
        }
}

// MARK: - UICollectionViewDataSource
extension GeneralViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let article = viewModel.sections[indexPath.section].items[indexPath.row] as? ArticleCellViewModel, let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "GeneralCollectionViewCell",
            for: indexPath
        ) as? GeneralCollectionViewCell else { return UICollectionViewCell() }
        
        cell.set(article: article)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension GeneralViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let article = viewModel.sections[indexPath.section].items[indexPath.row] as? ArticleCellViewModel else { return }
        
        navigationController?.pushViewController(
            NewsViewController(viewModel: NewsViewModel(article: article)),
            animated: true
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if indexPath.row == (viewModel.sections[0].items.count - 15) {
            viewModel.loadData(searchText: searchBar.text)
        }
    }
}

// MARK: - UISearchBarDelegate
extension GeneralViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        viewModel.loadData(searchText: text)
        
        searchBar.searchTextField.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.loadData(searchText: nil)
            
            searchBar.searchTextField.resignFirstResponder()
        }
    }
}
