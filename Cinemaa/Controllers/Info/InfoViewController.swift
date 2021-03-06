//
//  InfoViewController.swift
//  Cinemaa
//
//  Created by Клим on 26.08.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    //MARK: Public property
    var viewModel: InfoViewModelProtocol!
    
    //MARK: IBOutlet
    @IBOutlet var imagesCollectionView: UICollectionView!
    @IBOutlet var dataCollectionView: UICollectionView!
    @IBOutlet var timeCollectionView: UICollectionView!
    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var todayLabel: UILabel!
    @IBOutlet var tomorrowLabel: UILabel!
    
    
    //MARK: Override method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.isHidden = true
        
        descriptionLabel.text = viewModel.filmInfo.description
        
        imagesCollectionView.dataSource = self
        dataCollectionView.dataSource = self
        timeCollectionView.dataSource = self
        
        dataCollectionView.delegate = self
        timeCollectionView.delegate = self
        
        imagesCollectionView.register(UINib(nibName: "ImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "images")
        dataCollectionView.register(UINib(nibName: "DataCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "data")
        timeCollectionView.register(UINib(nibName: "TimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "time")
    }
    
    //MARK: IBAction
    @IBAction func didChangedSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            viewModel.firstSelected(descriptionLabel: descriptionLabel, todayLabel: todayLabel, tomorrowLabel: tomorrowLabel, dataCollectionView: dataCollectionView, timeCollectionView: timeCollectionView)
        } else {
            viewModel.secondSelected(descriptionLabel: descriptionLabel, todayLabel: todayLabel, tomorrowLabel: tomorrowLabel, dataCollectionView: dataCollectionView, timeCollectionView: timeCollectionView)
        }
    }
}

//MARK: UICollectionViewDataSource, UICollectionViewDelegate
extension InfoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case imagesCollectionView: return viewModel.countImages
        case dataCollectionView: return viewModel.countToday
        case timeCollectionView: return viewModel.countTommorow
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case imagesCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "images", for: indexPath) as! ImagesCollectionViewCell
            let imageViewModel = viewModel.imagesViewModel(for: indexPath)
            cell.modelView = imageViewModel
            return cell
        case dataCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "data", for: indexPath) as! DataCollectionViewCell
            let dataViewModel = viewModel.dataViewModel(for: indexPath)
            cell.viewModel = dataViewModel
            return cell
        case timeCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "time", for: indexPath) as! TimeCollectionViewCell
            let timeViewModel = viewModel.timeViewModel(for: indexPath)
            cell.viewModel = timeViewModel
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case dataCollectionView:
            viewModel.setIndexPath(for: indexPath)
            
            let siteViewModel = viewModel.siteViewModelToday()
            
            performSegue(withIdentifier: "sits", sender: siteViewModel)
        case timeCollectionView:
            viewModel.setIndexPath(for: indexPath)
            
            let siteViewModel = viewModel.siteViewModelTomorrow()
            
            performSegue(withIdentifier: "sits", sender: siteViewModel)
        default: break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let siteVC = segue.destination as! SiteViewController
        siteVC.viewModel = sender as? SiteViewModelProtocol
        navigationItem.backButtonTitle = ""
    }
}
