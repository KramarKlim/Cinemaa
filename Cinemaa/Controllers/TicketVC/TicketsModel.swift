//
//  TicketsModel.swift
//  Cinemaa
//
//  Created by Клим on 26.08.2021.
//

import Foundation

protocol TicketsModelProtocol {
    var tickets: [Ticket] { get }
    
    func oneTicketModel(for indexPath: IndexPath) -> OneTicketViewModelProtocol?
    func numberOfRows() -> Int
}

class TicketModel: TicketsModelProtocol {
    var tickets: [Ticket] {
        SaveData.shared.fetchData()
        return SaveData.shared.items
    }
    
    func oneTicketModel(for indexPath: IndexPath) -> OneTicketViewModelProtocol? {
        let ticket = tickets[indexPath.row]
        return OneTicketViewModel(name: ticket.name ?? "", time: ticket.time ?? "", price: Int(ticket.price))
    }
    
    func numberOfRows() -> Int {
        return tickets.count
    }
}
