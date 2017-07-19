//
//  ViewController.swift
//  Chap19_PinchGesture
//
//  Created by kwon on 19/07/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtPinch: UILabel!
    
    //초기 폰트 사이즈 저장하기 위한 변수(옵셔널)
    var initialFontSize: CGFloat?
    
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
        
        //터치 시작 될 때
        if (pinch.state == UIGestureRecognizerState.began){
            initialFontSize = txtPinch.font.pointSize
        //터치가 아닐 경우(터치 중 or 종료 등)
        }else{
            txtPinch.font = txtPinch.font.withSize(initialFontSize! * pinch.scale)
        }
    }
    


}

