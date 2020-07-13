//
//  PopOverTableViewController.swift
//  CryptoConverter
//
//  Created by User on 11/14/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import RealmSwift

protocol SelectQuoteDelegate {
    func baseQuoteSelected(_ quote: Quote)
    func convertQuoteSelected(_ quote: Quote)
}

class PopOverTableViewController: UITableViewController, UIPopoverControllerDelegate {
    
    var delegate: SelectQuoteDelegate?
    var senderSegue: String?
    var quoteArray = [Quote]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let load = QuoteProvider()
        

        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableData(notification: )), name: NSNotification.Name(rawValue: "sendQuoteArray"), object: nil)
        
        load.restartTimer()
        quoteArray = RealmMethods.readQuote()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return quoteArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = Bundle.main.loadNibNamed("QuoteHeader", owner: self, options: nil)?.first as? QuoteHeader
            else {
                return UITableViewCell()
        }
        cell.quoteHeaderRankLabel.text = "\(quoteArray[indexPath.row].rank)"
        cell.quoteHeaderImage.image = UIImage(named: quoteArray[indexPath.row].id)
        cell.quoteHeaderInfoLabel.text = "\(quoteArray[indexPath.row].name) \(quoteArray[indexPath.row].symbol)"
        cell.backgroundColor = .white


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if senderSegue == "baseQuoteSeque" {
            delegate?.baseQuoteSelected(quoteArray[indexPath.row])
        }
        else if senderSegue == "convertQuoteSeque" {
            
            delegate?.convertQuoteSelected(quoteArray[indexPath.row])
    }
        dismiss(animated: true, completion: nil)

}
    
    @objc func refreshTableData(notification: Notification) {
        if let generateQuotes = notification.object as? [Quote]
        {
            quoteArray = generateQuotes
        }
        tableView.reloadData()
    }


}
