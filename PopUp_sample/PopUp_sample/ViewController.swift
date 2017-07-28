//
//  ViewController.swift
//  PopUp_sample
//
//  Created by kwon on 28/07/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var effect: UIVisualEffect? = nil

    @IBOutlet var popUpView: UIView!
    
    @IBOutlet weak var effectView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        effect = effectView.effect
        effectView.effect = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnPopUp(_ sender: UIButton) {
        //animateIn()
        animateIn2()
    }
    
    @IBAction func btnPopUpClose(_ sender: UIButton) {
        animateOut()
    }

    func animateIn(){
        
        //popUpView 띄우기
        self.view.addSubview(popUpView)
        //popUpView center 위치 설정
        popUpView.center = self.view.center
        //크기 변환
        popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        //회전
//        popUpView.transform = CGAffineTransform.init(rotationAngle: 30.0)
        
        //애니메이션 효과(시간, 효과)
        UIView.animate(withDuration: 0.5, animations: {
            self.effectView.effect = self.effect
            self.popUpView.transform = CGAffineTransform.identity
        })
    }
    
    func animateIn2(){
        
        self.view.addSubview(popUpView)
        
        popUpView.frame = CGRect(x: 0, y: 150, width: popUpView.frame.width, height: popUpView.frame.height)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.effectView.effect = self.effect
            self.popUpView.transform = CGAffineTransform.init(translationX: 50.0, y: 0)
        })
        
        {
            (success:Bool) in
            UIView.animate(withDuration: 0.5, animations: {
                self.popUpView.transform = CGAffineTransform.identity
            })
        }
    }
    
    func animateOut(){
        UIView.animate(withDuration: 1.3, animations: {
            self.popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.effectView.effect = nil
        })
        
        {
            (success: Bool) in
            //popUpView 삭제
            self.popUpView.removeFromSuperview()
        }
    }
}

