//
//  ViewController.swift
//  newmmtsTimings
//
//  Created by Rajeev Rajeshuni on 2/19/17.
//  Copyright © 2017 Rajeev Rajeshuni. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    //Screen 1
    @IBOutlet weak var doneToolBar: UIToolbar!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    let picker1 = UIPickerView()
    var from = 0
    var to = 0
    let picker2 = UIPickerView()
    let stations:[String] = ["Select","Arts College", "Begumpet", "Bharatnagar", "Borabanda", "Chandanagar", "Dabirpura", "Falaknuma", "Fatehnagar", "Hafeezpet", "Hitech City", "Huppuguda", "Hyderabad", "Jamai Osmania", "James Street", "Kacheguda", "Khairatabad", "Lakdikapul", "Lingampalli", "Malakpet", "NatureCureHospital", "Necklace Road", "SanjeevaiahPark", "Secunderabad", "Sitafalmandi", "Vidyanagar", "Yakutpura"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker1.delegate = self
        self.picker1.dataSource = self
        self.picker2.delegate = self
        self.picker2.dataSource = self
        
        
        textField1.inputView = picker1
        textField1.inputAccessoryView = doneToolBar
        textField1.text = stations[0]

       
        textField2.inputView=picker2
        textField2.inputAccessoryView = doneToolBar
        textField2.text = stations[0]
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //navigationItem.title = "MMTS Timings"
        super.viewWillAppear(true)
        
    }
    @IBAction func doneButton(_ sender: Any) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn() -> Bool{
        return false
    }
    func showAlert(with text:String){
        let alert = UIAlertController(title:text,message:"",preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stations.count;
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stations[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == picker1)
        {
            textField1.text = stations[row]
            from = row
        }
        else
        {
            textField2.text = stations[row]
            to=row
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="resultsSegue")
        {
            let dest = segue.destination as! ResultsViewController
            dest.from = from
            dest.to = to
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(identifier=="resultsSegue")
        {
            if((from*to>0) && (from != to))
            {
                return true
            }
            if(from==0)
            {
                showAlert(with: "Select a FROM station.")
                        }
            else if(to==0)
            {
                showAlert(with: "Select a TO station.")
                
            }
            else if(from==to)
            {
                showAlert(with:"FROM and TO stations cannot be the same.")
            }
            return false
        }
        return true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        //navigationItem.title = "Back"
    }
}

