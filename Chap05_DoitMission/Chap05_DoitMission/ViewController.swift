//
//  ViewController.swift
//  Chap05_DoitMission
//
//  Created by kwon on 19/07/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate {
    
    let MAX_ARRAY_NUM = 9
    let PICKER_VIEW_COULUMN = 2
    var imageFileName = ["01.png", "02.png", "03.png",
                         "04.png", "05.png", "06.png", "07.png", "08.png", "09.png"]

    @IBOutlet weak var pickerImage1: UIPickerView!
    
    @IBOutlet weak var lbImagesFileName: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        pickerView.row
        return pickerView.numberOfRows(inComponent: 2)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
               
        return imageFileName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
            return imageFileName[row]
    }



}

