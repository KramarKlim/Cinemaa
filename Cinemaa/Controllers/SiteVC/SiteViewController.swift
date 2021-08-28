//
//  SiteViewController.swift
//  Cinemaa
//
//  Created by Клим on 26.08.2021.
//

import UIKit

class SiteViewController: UIViewController {
    
    //MARK: Public property
    var viewModel: SiteViewModelProtocol!
    
    //MARK: IBOutlets
    @IBOutlet var priceButton: UIButton!
    @IBOutlet var sitesCollectionView: UICollectionView!
    
    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        sitesCollectionView.allowsMultipleSelection = true
        sitesCollectionView.dataSource = self
        sitesCollectionView.delegate = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let checkVC = segue.destination as! CheckViewController
        checkVC.viewModel = sender as? CheckViewModelProtocol
        navigationItem.backButtonTitle = ""
    }
    
    //MARK: IBAction
    @IBAction func paymentButtonAction(_ sender: Any) {
        if viewModel.sitsNumber == 0 {
            alert(title: "Выберите место", message: "Вы не указали место")
        } else {
            let checkViewModel = viewModel.checkViewModel()
            performSegue(withIdentifier: "pay", sender: checkViewModel)
        }
    }
    
    //MARK: Private method
    private func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}

//MARK: UICollectionViewDataSource, UICollectionViewDelegate
extension SiteViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "site", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SofaCollectionViewCell
        
        let image = viewModel.sofaViewModel(for: 1)
        cell.viewModel = image
        
        viewModel.sitsNumber += 1
        priceButton.setTitle("\(viewModel.price) рублей", for: .normal)
        
        viewModel.sitsCount.append(indexPath.row + 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SofaCollectionViewCell
        let image = viewModel.sofaViewModel(for: 0)
        
        cell.viewModel = image
        viewModel.sitsNumber -= 1
        
        priceButton.setTitle("\(viewModel.price) рублей", for: .normal)
        
        viewModel.removeNeededSit(for: indexPath.row+1)
        viewModel.sitsCount.remove(at: viewModel.remove!)
        
    }
}
