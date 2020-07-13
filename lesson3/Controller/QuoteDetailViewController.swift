//
//  QuoteDetailViewController.swift
//  CryptoConverter
//
//  Created by User on 11/6/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class QuoteDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let screen = UIScreen.main.bounds

    @IBOutlet weak var quoteLogoImage: UIImageView!
    @IBOutlet weak var quoteSymbolLabel: UILabel!
    @IBOutlet weak var quoteNameLabel: UILabel!
    @IBOutlet weak var quoteInfoTableView: UITableView!
    
    var quote: Quote?
    var textForRow: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     quoteInfoTableView.delegate = self
     quoteInfoTableView.dataSource = self
        
        if let quote = quote {
            textForRow = Detail.textForRow(quote: quote)
            quoteLogoImage.image = UIImage(named: quote.id)
            quoteNameLabel.text = quote.name
            quoteSymbolLabel.text = quote.symbol
            
        }

    }
       
       func numberOfSections(in tableView: UITableView) -> Int {
           return textForRow.count
       }
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textForRow[section].count
       }
    
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        cell.textLabel?.text = textForRow[indexPath.section][indexPath.row]
        
        if screen.height > screen.width {
            cell.textLabel?.font = UIFont.systemFont(ofSize: screen.height/40)
        }
        else {
            cell.textLabel?.font = UIFont.systemFont(ofSize: screen.width/40)

        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Detail.headerTitles[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            if screen.height > screen.width {
                header.textLabel?.font = UIFont.systemFont(ofSize: screen.height/40)
            }
            else {
                header.textLabel?.font = UIFont.systemFont(ofSize: screen.width/40)
            }
            header.tintColor = .lightGray
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return screen.height > screen.width ? screen.height/30 : screen.width/30
    }
 }
