//
//  ViewController.swift
//  AnimalAPP
//
//  Created by hui liu on 12/8/20.
//

import UIKit

class AnimeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    fileprivate let cellId = "cellId"
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    let animeViewModel = AnimeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        collectionView.register(ResultCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .white
        setupSearchBar()
        setupLoadingIndicator()
        setupSearchViewModelObserver()
        animeViewModel.fetchFirstTimeData()
    }
    
    fileprivate func setupSearchViewModelObserver() {
        animeViewModel.results.bind { [weak self] (_) in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        animeViewModel.isSearching.bind { [weak self] (isSearching) in
            guard let isSearching = isSearching else { return }
            DispatchQueue.main.async {
                isSearching ? self?.loadingIndicator.startAnimating() : self?.loadingIndicator.startAnimating()
                self?.loadingIndicator.isHidden = !isSearching
            }
        }
    }
    
    fileprivate func setupLoadingIndicator() {
        loadingIndicator.color = .lightGray
        view.addSubview(loadingIndicator)
        loadingIndicator.centerInSuperview(size: .init(width: 60, height: 60))
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.animeViewModel.performSearch(searchText)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animeViewModel.results.value?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ResultCell
        cell.result = animeViewModel.results.value?[indexPath.item]
        cell.getButton.tag = indexPath.row
        cell.getButton.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        return cell
    }
    
    @objc func buttonSelected(sender: UIButton){
        print(sender.tag)
        if let url = NSURL(string: "\(animeViewModel.results.value?[sender.tag].url ?? "")"){
            UIApplication.shared.openURL(url as URL)
            }
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 120)
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

