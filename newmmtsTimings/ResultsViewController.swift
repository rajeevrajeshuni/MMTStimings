//
//  File.swift
//  newmmtsTimings
//
//  Created by Rajeev Rajeshuni on 2/19/17.
//  Copyright © 2017 Rajeev Rajeshuni. All rights reserved.
//

import UIKit
import Foundation

class ResultsViewController:UITableViewController{
    var from:Int = -1
    var to:Int  = -1
    var timings:[String] = [];
    var stations:[String] = ["Select","Arts College", "Begumpet", "Bharatnagar", "Borabanda", "Chandanagar", "Dabirpura", "Falaknuma", "Fatehnagar", "Hafeezpet", "Hitech City", "Huppuguda", "Hyderabad", "Jamai Osmania", "James Street", "Kacheguda", "Khairatabad", "Lakdikapul", "Lingampalli", "Malakpet", "NatureCureHospital", "Necklace Road", "SanjeevaiahPark", "Secunderabad", "Sitafalmandi", "Vidyanagar", "Yakutpura"]
    var contents = ""
    override func viewDidLoad() {
        print("from is \(from)")
        print("to is \(to)")
        tableView.allowsSelection = false
        loadData()
        
       // let button = UIBarButtonItem(title:"Back",style:.plain,target:self,action:)
        //navigationItem.backBarButtonItem = button
    }
    func loadData(){
        let filePath = Bundle.main.url(forResource: "final_data", withExtension: "csv")
       
        do{
            contents = try String(contentsOf:filePath!)
       
        }
        catch{
            print("Error found")
        }
        let rawContentArray = contents.components(separatedBy: "\n")
        for tempTime in rawContentArray{
            var row = tempTime.components(separatedBy: ",")
            if let tfrom = Int(row[0])
            {
                if let tto = Int(row[1]){
                    if(tfrom == from && tto == to)
                    {
                        timings = row
                    }
                }
            }
        }
        
    }
    func setText(for cell:UITableViewCell,with index:Int)
    {
        //print(index)
        let label1 = cell.viewWithTag(101) as! UILabel
        label1.text = timings[3*index-1]
        
        let label2 = cell.viewWithTag(102) as! UILabel
        label2.text = timings[3*index]
        
        let label3 = cell.viewWithTag(103) as! UILabel
        label3.text = timings[3*index+1]
        
    }
    func setText(for cell:UITableViewCell)
    {
        let label1 = cell.viewWithTag(101) as! UILabel
        label1.text = "Train No."
        
        let label2 = cell.viewWithTag(102) as! UILabel
        label2.text = stations[from]
        
        let label3 = cell.viewWithTag(103) as! UILabel
        label3.text = stations[to]
        
    }

    override func tableView(_ tableView:UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier:"trainItem",for:indexPath);
        let index = (indexPath.row)
       
            setText(for: cell, with: index+1)
               return cell;
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell")! as UITableViewCell
        setText(for: cell)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "footerCell")! as UITableViewCell
        let label1 = cell.viewWithTag(101) as! UILabel
        label1.text = "* -> Does not run on Sunday"
        let label2 = cell.viewWithTag(102) as! UILabel
        label2.text = "** -> Women's Special"
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 52;
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35;
    }
    override func tableView(_ tableView : UITableView, numberOfRowsInSection section:Int)->Int{
        let ans = (timings.count-2)/3
        return ans;
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Train"
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
}





