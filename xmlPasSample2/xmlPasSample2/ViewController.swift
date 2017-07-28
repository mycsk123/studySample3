//
//  ViewController.swift
//  xmlPasSample2
//
//  Created by kwon on 28/07/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {
    
    var parser: XMLParser? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = URL(string: "http://data.busan.go.kr/openBus/service/busanBIMS2/busStop?serviceKey=slg7RJ8L%2FCOauR%2FaIz85i2dqPOIbESUB2oT83luBfprZZQy5C5t9gdyOn7FwwPFHMAMpgwZadPce0vCiDFiQLg%3D%3D&pageNo=1&startPage=1&numOfRows=10&pageSize=10&bstopnm=%EB%B6%80%EC%82%B0%EC%8B%9C%EC%B2%AD&arsno=13045")
        
        parser = XMLParser(contentsOf: url!)
        
        parser?.delegate = self
        
        if let suc = parser?.parse(){
            
        }
        else{
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

