//
//  ViewController.swift
//  Chap05_Pickerview
//
//  Created by kwon on 19/07/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import UIKit

//피켜 뷰 델리게이트 메서드 사용을 위해 UIPickerviewDelegate 상속받기
class ViewController: UIViewController, UIPickerViewDelegate {
    
    let MAX_ARRAY_NUM = 9
    let PICKER_VIEW_COULUMN = 1
    var imageArray = [UIImage?]()
    var imageFileName = ["01.png", "02.png", "03.png",
        "04.png", "05.png", "06.png", "07.png", "08.png", "09.png"]
    var PICKER_VIEW_HEIGHT: CGFloat = 80
    

    @IBOutlet weak var pickerImage: UIPickerView!
    
    @IBOutlet weak var lbImagesFileName: UILabel!
    
    @IBOutlet weak var ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for i in 0..<MAX_ARRAY_NUM{
            let image = UIImage(named: imageFileName[i])
            imageArray.append(image)
        }
        
        lbImagesFileName.text = imageFileName[0]
        ImageView.image = imageArray[0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //피커 뷰에게 컴포넌트의 수를 정수 값으로 넘겨주는 델리게이트 메서드
    func numberOfComponentsInPickerView(in pickerView: UIPickerView) -> Int{
        return PICKER_VIEW_COULUMN
    }
    
    //피커 뷰에게 컴포넌트의 높이를 정수 값으로 넘겨주는 델리게이트 메서드
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
        return PICKER_VIEW_HEIGHT
    }
    
    //피커 뷰에게 컴포넌트의 열의 개수를 정수 값으로 넘겨줌
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return imageFileName.count
    }
    
    //피커 뷰에서 컴포넌터의 각 열의 뷰를 uiview타입의 값으로 넘겨줌
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView{
        let ImageView = UIImageView(image: imageArray[row])
        ImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        
        return ImageView
    }
    
//    //피커 뷰에게 컴포넌트의 각 열의 타이틀 문자열 값으로 넘겨줌
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
//        return imageFileName[row]
//    }
    
    //피커 뷰 롤렛에서 선택한 row 값을 저장
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        lbImagesFileName.text = imageFileName[row]
        ImageView.image = imageArray[row]
    }


}

