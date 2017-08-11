//
//  OurWorkTVC.swift
//  CompanyApp
//
//  Created by Milos Hovjecki on 7/24/17.
//  Copyright © 2017 Hajora. All rights reserved.
//

import UIKit
import Alamofire

class OurWorkTVC: UITableViewController {
    
    //MARK: Properties
    
    var allOurWork = [OurWorkFile]()
    var ourWork: OurWorkFile!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        downloadOurWorkData {
            
            // some code...
            
        }

        // loadDataTest()

        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return allOurWork.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let ourWorkCellIdentifier = "OurWorkCell"
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ourWorkCellIdentifier, for: indexPath) as? OurWorkCell {
    
        let forOurWork = allOurWork[indexPath.row]
        
        let imageLoad = UIImage(named: "\(forOurWork.image)")
        
        cell.ourWorkTitleLbl?.text = forOurWork.name
        cell.ourWorkSubtitleLbl?.text = forOurWork.details
        cell.ourWorkImage?.image = imageLoad

        return cell
        
        } else {
            
            return OurWorkCell()
            
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let thisIsOurWork = allOurWork[indexPath.row]
        
        performSegue(withIdentifier: "toOurWorkDetailsVC", sender: thisIsOurWork)
        
    }
    
    
    func downloadOurWorkData (completed: @escaping DownloadComplete) {
        
        Alamofire.request(ALL_EDUCATION_URL).responseJSON { (response) in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let dictList = dict["Educations"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in dictList {
                        
                        let ourWork = OurWorkFile(ourWorkDict: obj)
                        
                        self.allOurWork.append(ourWork)
                        
                    }
                    
                    self.tableView.reloadData()
                    
                }
                
            }
            
            completed()
            
        }
        
    }

}
