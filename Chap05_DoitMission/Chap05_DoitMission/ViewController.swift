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
    var imageArray = [UIImage?]()
    var PICKER_VIEW_HEIGHT: CGFloat = 80
    
    @IBOutlet weak var pickerImage1: UIPickerView!
    
    @IBOutlet weak var lbImagesFileName: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for i in 0..<MAX_ARRAY_NUM{
            let image = UIImage(named: imageFileName[i])
            imageArray.append(image)
        }
        
        lbImagesFileName.text = imageFileName[0]
        imgView.image = imageArray[0]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(_ pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COULUMN
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
               
        return imageFileName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        //피커 뷰 컨퍼넌트 순번
        if(component == 0){
            lbImagesFileName.text = imageFileName[row]
        }else if(component == 1){
            imgView.image = imageArray[row]
        }

    }

    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component:
        Int, reusing view: UIView?) -> UIView{
        
        let imgView = UIImageView(image: imageArray[row])
        imgView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        return imgView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
        return PICKER_VIEW_HEIGHT
    }

    



}

