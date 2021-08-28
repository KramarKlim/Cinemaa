//
//  TicketsTableViewController.swift
//  Cinemaa
//
//  Created by Клим on 26.08.2021.
//

import UIKit

class TicketsTableViewController: UITableViewController {
    
    //MARK: Public property
    var model: TicketsModelProtocol! = TicketModel()
    
    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Билеты"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        self.navigationController?.navigationBar.topItem?.title = "Билеты"
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        return model.numberOfRows()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ticket", for: indexPath) as! OneTicketTableViewCell
        let ticket = model.oneTicketModel(for: indexPath)
        cell.viewModel = ticket

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            SaveData.shared.deleteTask(for: indexPath.row)
            let deleteIndexPath = IndexPath(row: indexPath.row, section: 0)
            tableView.deleteRows(at: [deleteIndexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
