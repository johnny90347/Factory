//
//  RDTaskListVC.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/1.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit

class RDTaskListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var taskListTableview: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        taskListTableview.delegate = self
        taskListTableview.dataSource = self
        
        taskListTableview.rowHeight = UITableView.automaticDimension
        taskListTableview.estimatedRowHeight = 120
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RDcell", for: indexPath) as! RDTaskListCustomCell
        
        cell.taskLabel.text = "sdkdsjvsnvjsvksvndsvjsdvndsvjdsvnjsvjnvjsfvljfnvjsfnvjfdnvjfsdnvjdsfnvjfsnvjdfsnvjdfsnvjsfdnvjdfnjvndfsjvndfjvndfjsvnslfjdvnsjfn"
        return cell
        
    }
    
    
    func getRDTask(){
        
        
        
        
    }

    
    

}
