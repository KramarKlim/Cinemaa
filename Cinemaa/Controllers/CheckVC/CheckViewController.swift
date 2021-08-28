//
//  CheckViewController.swift
//  Cinemaa
//
//  Created by Клим on 26.08.2021.
//

import UIKit

class CheckViewController: UIViewController {
    
    //MARK: Public property
    var viewModel: CheckViewModelProtocol!

    //MARK: IBOutlets
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var sitsLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    //MARK: Override method
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    //MARK: Private method
    private func setUp() {
        timeLabel.text = "Время: \(viewModel.time)"
        sitsLabel.text = "\(viewModel.sits.toPrint)"
        nameLabel.text = viewModel.name
        countLabel.text = "\(viewModel.count)"
        priceLabel.text = "\(viewModel.price) руб"
    }
    
    //MARK: IBAction
    @IBAction func doneButtonAction(_ sender: Any) {
        
        SaveData.shared.saveItem(name: viewModel.name, time: viewModel.time, price: Int16(viewModel.price), count: Int16(viewModel.count))
        
        self.navigationController?.popViewController(animated: true)
    }
}
