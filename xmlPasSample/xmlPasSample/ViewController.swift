//
//  ViewController.swift
//  xmlPasSample
//
//  Created by kwon on 19/07/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import UIKit

//xml 파싱을 위해 XMLParserDelegate 상속
//plist에 설정 변경(app transport security~ / allow arbitrary loads -yes)
class ViewController: UIViewController, XMLParserDelegate {

    @IBOutlet weak var lbData: UILabel!
    
    var parser: XMLParser? = nil
    var isName: Bool = false
    var isCost: Bool = false
    var foodInfos : [(String?, String?)] = [(String?, String?)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "http://api.androidhive.info/pizza/?format=xml")
        
        parser = XMLParser(contentsOf: url!)
        //딜리게이트 활성화
        parser?.delegate = self
        
        //parser?.parse()
        
        if let success = parser?.parse(){
            print("파싱성공")
            
            //라벨에 파싱받은 값들 -> 문자열 출력
            var datas: String = ""
            for i in 0..<foodInfos.count{
                datas += foodInfos[i].0! + ", " + foodInfos[i].1! + "\n"
                lbData.numberOfLines += 1
            }
            lbData.text = datas
        }else{
            lbData.text = "파싱 실패"
        }
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //필요 태그값에 표시하기
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if(elementName == "name"){
            isName = true
        }else if(elementName == "cost"){
            isCost = true
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if(elementName == "name"){
            isName = false
        }else if(elementName == "cost"){
            isCost = false
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if isName{
            foodInfos.append((string, "0"))
        }else if isCost{
            foodInfos[foodInfos.count - 1].1 = string
        }
    }



}

