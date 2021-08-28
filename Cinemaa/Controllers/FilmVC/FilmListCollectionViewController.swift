//
//  FilmListCollectionViewController.swift
//  Cinemaa
//
//  Created by Клим on 26.08.2021.
//

import UIKit

class FilmListCollectionViewController: UICollectionViewController {
    
    //MARK: Public property
    var viewModel: FilmListViewModelProtocol! = FilmListViewModel()

    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Фильмы"
        self.collectionView.register(UINib(nibName: "FilmCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Фильмы"
    }
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FilmCollectionViewCell
        let filmViewModel = viewModel.filmViewModel(for: indexPath)
        cell.viewModel = filmViewModel
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.indexPath(for: indexPath)
        let infoViewModel = viewModel.infoViewModel()
        
        performSegue(withIdentifier: "info", sender: infoViewModel)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let infoVC = segue.destination as! InfoViewController
        infoVC.viewModel = sender as? InfoViewModelProtocol
        navigationItem.backButtonTitle = ""
    }
}
