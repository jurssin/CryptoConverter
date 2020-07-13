//
//  QuoteTableViewController.swift
//  lesson3
//
//  Created by User on 11/6/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import PullToRefresh
import AnimatableReload
import SwipeCellKit
import RealmSwift
import SwiftySound
import AVFoundation
import AudioToolbox


class QuoteTableViewController: UITableViewController {
    
    let refresher = PullToRefresh()
    var isSelectMode = false
    var isBaseQuoteSelectMode = false
    var quoteProvider = QuoteProvider()
   // var oldQuoteArray = [Quote]()
    var oldQuotePrices: [String: String] = [:]
    var updatedQuoteArray: [Quote] = []
  //  var filteredQuoteArray = [Quote]()
   // var state = 0
  //  var quotes: [QuoteCached] = []

    @IBOutlet weak var timerLabel: UIBarButtonItem!
    
  //  private var dogSound: Sound?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let dogUrl = Bundle.main.url(forResource: "sound1", withExtension: "wav") {
//            dogSound = Sound(url: dogUrl)
 //       }
        
        updatedQuoteArray = RealmMethods.readQuote()
        
        
        if UserDefaults.standard.bool(forKey: "isFirstLaunch") == false {
            let alert = UIAlertController(title: "Welcome!", message: "You can use this app to check the latest prices of cryptocurrencies, search for your favourite ones, and convert between them easily", preferredStyle: .alert)
            let action = UIAlertAction(title: "Start", style: .default)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
        }

        
        
        
      if !isSelectMode {
            tableView.addPullToRefresh(refresher) {
                self.quoteProvider.restartTimer()
            }
      }
        print("viewDidLoad tableQuotes")
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableData(_ :)), name: NSNotification.Name(rawValue: "sendQuoteArray") , object: nil)
        
        quoteProvider = QuoteProvider()

    }
    
      deinit {
        tableView.removeAllPullToRefresh()
      }
    
    
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
  //      Sound.play(file: "sound1", fileExtension: "wav", numberOfLoops: 2)
        AudioServicesPlayAlertSound(1306)
        if timerLabel.title == "10s" {
            quoteProvider.restartTimer(timeInterval: 10.0)
        }
        else if timerLabel.title == "1.5m" {
            quoteProvider.restartTimer(timeInterval: 30.0)
        }
        else if timerLabel.title == "10s" {
            quoteProvider.restartTimer(timeInterval: 90.0)
        }
        else if timerLabel.title == "5m" {
            quoteProvider.restartTimer()
        }
    }
    @IBAction func timerButtonPressed(_ sender: UIBarButtonItem) {
        AudioServicesPlayAlertSound(1306)

 //   Sound.play(file: "sound1", fileExtension: "wav", numberOfLoops: 5)

        if timerLabel.title == "5m" {
            quoteProvider.restartTimer(timeInterval: 10.0)
            timerLabel.title = "10s"
        }
        else if timerLabel.title == "10s" {
            quoteProvider.restartTimer(timeInterval: 30.0)
            timerLabel.title = "30s"
        }
        else if timerLabel.title == "30s" {
            quoteProvider.restartTimer(timeInterval: 90.0)
            timerLabel.title = "1.5m"
        }
        else if timerLabel.title == "1.5m" {
            quoteProvider.restartTimer()
            timerLabel.title = "5m"
        }
        
        
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return updatedQuoteArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCellIdentifier", for: indexPath) as? QuoteCell else {
            return UITableViewCell()
        }
        let quoteForCell = updatedQuoteArray[indexPath.section]
        
//      let oldQuote = oldQuoteArray.first { (quote) -> Bool in
//            quote.id == quoteForCell.id
//        }
        
        if let priceUSD = Double(quoteForCell.priceUSD) {
            cell.priceLabel.text = "$\(String(format: "%.2f", priceUSD))"
        }
        else {
            cell.priceLabel.text = "$----"
        }
        
        cell.marketcapLabel.text = "Market Cap: $\((Formatter.numberFormatter(Double(quoteForCell.marketCapUSD) ?? 0)))"
        cell.availableSupplyLabel.text="Available: \(Formatter.numberFormatter(Double(quoteForCell.availableSupply) ?? 0)) \(quoteForCell.symbol)"
        cell.volumeLabel.text = "Volume(24h): $\(Formatter.numberFormatter(Double(quoteForCell.volumeUSD24H) ?? 0))"
        cell.updateLabel.text = Formatter.dataFormatter(Int(quoteForCell.lastUpdated) ?? 0)
        
        if let oldQuote = oldQuotePrices[quoteForCell.symbol] {
            if let oldPrice = Double(oldQuote), let newPrice = Double(quoteForCell.priceUSD) {
                let percentChange = newPrice/oldPrice - 1
                cell.changeLabel.text = "\(String(format: "%.4f", percentChange))%"
                cell.changeLabel.textColor = percentChange > 0 ? .green : .red
            }
        } else {
                cell.changeLabel.text = "0.0000%"
                cell.changeLabel.textColor = .black
            }
       // cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let quoteHeaderView = Bundle.main.loadNibNamed("QuoteHeader", owner: self, options: nil)?.first as? QuoteHeader else {
            return UIView()
        }
        
        quoteHeaderView.quoteHeaderRankLabel.text = "\(updatedQuoteArray[section].rank)"
        quoteHeaderView.quoteHeaderImage.image = UIImage(named: updatedQuoteArray[section].id)
        quoteHeaderView.quoteHeaderInfoLabel.text = "\(updatedQuoteArray[section].name) (\(updatedQuoteArray[section].symbol))"
        
        return quoteHeaderView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    @objc func refreshTableData(_ notification: Notification) {
        if let updateQuoteArray = notification.object as? [Quote], let oldQuotePrice = notification.userInfo as? [String: String] {
            RealmMethods.saveQuote(quotes: updateQuoteArray)
            self.oldQuotePrices = oldQuotePrice
        }
        
        updatedQuoteArray = RealmMethods.readQuote()
        
        tableView.reloadData()
        
        print(" tableView.reloadData")
        tableView.reloadData()
        
        if !isSelectMode {
            AnimatableReload.reload(tableView: tableView, animationDirection: "right")
        }
        tableView.endAllRefreshing()
    }
        
    
  /*  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSelectMode {
            if isBaseQuoteSelectMode {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sendBaseQuote"), object: updatedQuoteArray[indexPath.section])
            }
            else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sendConvertQuote"), object: updatedQuoteArray[indexPath.section])
            }
            dismiss(animated: true, completion: nil)
            isBaseQuoteSelectMode = false
            isSelectMode = false
        }
        else {
            performSegue(withIdentifier: "toQuoteDetail", sender: updatedQuoteArray[indexPath.section])
        }
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        AudioServicesPlayAlertSound(1306)

        guard segue.identifier == "toQuoteDetail"  else {
            return
        }
        
        if let quoteDetailView = segue.destination as? QuoteDetailViewController {
            if let cell = sender as? QuoteCell {
                if let indexPath = tableView.indexPath(for: cell ) {
                    let quote = updatedQuoteArray[indexPath.section]
                    quoteDetailView.quote = quote
                }
                    
                    
                }
            }
        }
 

    }
    


