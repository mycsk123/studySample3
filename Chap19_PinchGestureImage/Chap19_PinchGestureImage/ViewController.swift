//
//  ViewController.swift
//  Chap19_PinchGestureImage
//
//  Created by kwon on 19/07/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //제스쳐 등록(리스너)
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.doPinch(_:)))
        self.view.addGestureRecognizer(pinch)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //핀치 제스쳐 동작시 호출될 함수
    func doPinch(_ pinch: UIPinchGestureRecognizer){
        
        //이미지를 스케일에 맞게 변환
        imgView.transform = imgView.transform.scaledBy(x: pinch.scale, y: pinch.scale)
        //다음 변환을 위해 핀치의 스케일 속성을 1로 설정
        pinch.scale = 1
    }

}

