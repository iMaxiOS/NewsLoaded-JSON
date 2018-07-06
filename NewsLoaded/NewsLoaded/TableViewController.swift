//
//  ViewController.swift
//  NewsLoaded
//
//  Created by iMaxiOS on 7/6/18.
//  Copyright © 2018 Maxim Granchenko. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        NotificationCenter.default.addObserver(forName: Model.nNewsLoaded, object: nil, queue: OperationQueue.main) { (notification) in
            self.tableView.reloadData()
        }
        
        model.loadNewsJSON()
    }

    //MARK: Table View Data Sourse

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.newsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let news = model.newsArray[indexPath.row]

        cell.textLabel?.text = news["title"] as? String
        cell.detailTextLabel?.text = news["title"] as? String

        return cell
    }
    
    
}

