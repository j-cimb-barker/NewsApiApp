//
//  NewsTableViewController.swift
//  NewsApiApp
//
//  Created by Josh Barker on 08/12/2020.
//

import UIKit

class NewsTableViewController: UITableViewController {

    var articles = [Article] ()
    
    let NEWS_CELL_ID = "NEWS_CELL_ID"
    
    let KEYWORD = "Art"
    
    let LANGUAGE = "en"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = KEYWORD + " Stories"
        
        self.tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: NEWS_CELL_ID)
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 85
        
       
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NewsManager.shared.getNewsArticles(keyword: KEYWORD.lowercased(), language: LANGUAGE.lowercased()) { (errorStr: String, _ newsArticles: [ Article ]) in
            
            if (errorStr != "") {
                DispatchQueue.main.async { [unowned self] in
                    self.showUserAlert(msg: errorStr)
                }
                
            } else {
                self.articles = newsArticles
                
                DispatchQueue.main.async { [unowned self] in
                    self.tableView.reloadData()
                }
            }
            
            
        }
    }
    
    func showUserAlert (msg: String) {
        
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell?

        // Configure the cell...
        let myCell:NewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: NEWS_CELL_ID, for: indexPath) as! NewsTableViewCell

        myCell.populate(article: self.articles [indexPath.row])
        
        myCell.headingLabel.preferredMaxLayoutWidth = self.tableView.bounds.width - (self.tableView.bounds.width / 2)
        myCell.contentLabel.preferredMaxLayoutWidth = self.tableView.bounds.width - 50
        
        myCell.setNeedsUpdateConstraints()
        myCell.updateConstraintsIfNeeded()
        
        cell = myCell
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let article = self.articles [indexPath.row]
        
        guard article.url != nil else {
            return
        }
        
        UIApplication.shared.open(article.url!)
    }

   

}
