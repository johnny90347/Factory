//
//  RDTableViewController.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/1.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit

class RDTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        tableView.register(UINib(nibName: "RDTaskListCell", bundle: nil), forCellReuseIdentifier: "RDcell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "RDcell", for: indexPath) as! RDTaskListCustomCell
//        return cell
//    }

  
}
