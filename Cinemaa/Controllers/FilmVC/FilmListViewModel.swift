//
//  FilmListViewModel.swift
//  Cinemaa
//
//  Created by Клим on 26.08.2021.
//

import Foundation

protocol FilmListViewModelProtocol {
    var count: Int { get }
    var films: [FilmModel] { get }
    
    func indexPath(for indexPath: IndexPath)
    func infoViewModel() -> InfoViewModelProtocol?
    func filmViewModel(for indexPath: IndexPath) -> FilmViewModelProtocol?
}

class FilmListViewModel: FilmListViewModelProtocol {
    var count: Int {
        films.count
    }
    
    var indexPath: IndexPath?
    
    var films: [FilmModel] = DataManager.shared.movies
    
    func filmViewModel(for indexPath: IndexPath) -> FilmViewModelProtocol? {
        let film = films[indexPath.row]
        return FilmViewModel(film: film)
    }
    //MARK: ddd
    func indexPath(for indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    func infoViewModel() -> InfoViewModelProtocol? {
        guard let indexPath = indexPath else { return nil }
        let newFilm = films[indexPath.row]
        return InfoViewModel(filmName: newFilm.title)
    }
}
