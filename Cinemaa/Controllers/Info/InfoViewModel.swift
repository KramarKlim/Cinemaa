//
//  InfoViewModel.swift
//  Cinemaa
//
//  Created by Клим on 26.08.2021.
//

import UIKit

protocol InfoViewModelProtocol {
    var filmInfo: TimeVCModel { get }
    var filmName: String { get }
    var countToday: Int { get }
    var countTommorow: Int { get }
    var countImages: Int { get }
    
    init(filmName: String)
    
    func imagesViewModel(for indexPath: IndexPath) -> ImagesModelViewProtocol?
    func dataViewModel(for indexPath: IndexPath) -> DataViewModelProtocol?
    func timeViewModel(for indexPath: IndexPath) -> TimeViewModelProtocol?
    func firstSelected(descriptionLabel: UILabel, todayLabel: UILabel, tomorrowLabel: UILabel, dataCollectionView: UICollectionView, timeCollectionView: UICollectionView)
    func secondSelected(descriptionLabel: UILabel, todayLabel: UILabel, tomorrowLabel: UILabel, dataCollectionView: UICollectionView, timeCollectionView: UICollectionView)
    func siteViewModelToday() -> SiteViewModelProtocol?
    func siteViewModelTomorrow() -> SiteViewModelProtocol?
    func setIndexPath(for indexPath: IndexPath)
}

class InfoViewModel: InfoViewModelProtocol {
    var filmInfo: TimeVCModel {
        return DataManager.shared.filmVC["\(filmName)"]!
    }
    
    var countImages: Int {
        filmInfo.image.count
    }
    
    var countToday: Int {
        filmInfo.today.count
    }
    
    var countTommorow: Int {
        filmInfo.tomorrow.count
    }
    
    var indexPath: IndexPath?
    
    var filmName: String
    
    required init(filmName: String) {
        self.filmName = filmName
    }
    
    func setIndexPath(for indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    func imagesViewModel(for indexPath: IndexPath) -> ImagesModelViewProtocol? {
        let image = filmInfo.image[indexPath.row]
        return ImagesModelView(imagesString: image)
    }
    
    func dataViewModel(for indexPath: IndexPath) -> DataViewModelProtocol? {
        let data = filmInfo.today[indexPath.row]
        return DataViewModel(info: data)
    }
    
    func timeViewModel(for indexPath: IndexPath) -> TimeViewModelProtocol? {
        let time = filmInfo.tomorrow[indexPath.row]
        return TimeViewModel(information: time)
    }
    
    func firstSelected(descriptionLabel: UILabel, todayLabel: UILabel, tomorrowLabel: UILabel, dataCollectionView: UICollectionView, timeCollectionView: UICollectionView) {
        descriptionLabel.isHidden = true
        todayLabel.isHidden = false
        tomorrowLabel.isHidden = false
        dataCollectionView.isHidden = false
        timeCollectionView.isHidden = false
    }
    func secondSelected(descriptionLabel: UILabel, todayLabel: UILabel, tomorrowLabel: UILabel, dataCollectionView: UICollectionView, timeCollectionView: UICollectionView) {
        descriptionLabel.isHidden = false
        todayLabel.isHidden = true
        tomorrowLabel.isHidden = true
        dataCollectionView.isHidden = true
        timeCollectionView.isHidden = true
    }
    
    func siteViewModelToday() -> SiteViewModelProtocol? {
        guard let indexPath = indexPath else { return nil}
        let ticket = filmInfo.today[indexPath.row]
        return SiteViewModel(name: filmName, ticket: ticket)
    }

    func siteViewModelTomorrow() -> SiteViewModelProtocol? {
        guard let indexPath = indexPath else { return nil}
        let ticket = filmInfo.tomorrow[indexPath.row]
        return SiteViewModel(name: filmName, ticket: ticket)
    }
}
