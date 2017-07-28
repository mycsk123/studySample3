//
//  ViewController.swift
//  PopUp_sampe2
//
//  Created by kwon on 28/07/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnPopUp(_ sender: UIButton) {
        
//        let popupViewController = storyboard?.instantiateViewController(withIdentifier: "popUp") as! PopUpViewController
        
        //name은 PopUpViewController가 포함된 스토리보드
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUp") as! PopUpViewController
        
        self.addChildViewController(controller)
        controller.view.frame = self.view.frame
        controller.popUpView.center = self.view.center
        self.view.addSubview(controller.popUpView)
        
    }

}

