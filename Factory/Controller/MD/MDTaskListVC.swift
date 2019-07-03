//
//  MDTaskListVC.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/3.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit

class MDTaskListVC: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    
    var taskList = [MDTaskInfo]()
    
    
    @IBOutlet weak var taskListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskListTableView.dataSource = self
        taskListTableView.delegate = self
        
        taskListTableView.rowHeight = UITableView.automaticDimension
        taskListTableView.estimatedRowHeight = 120
    }
    

   
    //MARK: - TableViewDataSorce
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mdCell", for: indexPath) as! MDTaskListCustomCell
        
        
        return cell
    }

}
