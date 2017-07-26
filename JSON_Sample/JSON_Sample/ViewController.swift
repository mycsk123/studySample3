//
//  ViewController.swift
//  JSON_Sample
//
//  Created by kwon on 26/07/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var json_data : [String : [ [String : String] ]] = [String : [ [String : String] ]]()

    var json_data2 : [String:Any] = [String:Any]()
    
    @IBOutlet weak var lbText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        JSON_Test1()
        Print_JSON()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func JSON_Test1(){
        json_data["menu"] = [ [String : String] ]()
        
        var in_jason: [String : String] = [String : String]()
        
        in_jason["id"] = "1"
        in_jason["name"] = "Margherita"
        in_jason["cost"] = "155"
        in_jason["description"] = "Single cheese topping"
        
        //in_jason 안의 데이터가 복사되어 in_data딕셔너리에 들어감
        json_data["menu"]?.append(in_jason)
        
        in_jason["id"] = "2"
        in_jason["name"] = "Double chees margherita"
        in_jason["cost"] = "255"
        in_jason["description"] = "Loaded with extra chees"
        
        json_data["menu"]?.append(in_jason)
    }
    
    
    func Print_JSON(){
        
        var data: String = ""
        
        for key1 in json_data.keys{
            
            data += key1 + "\n"
            lbText.numberOfLines += 1
            
            for i in 0..<json_data[key1]!.count{
                
                for key2 in (json_data[key1]?[i].keys)!{
                    
                    data += key2 + " : "
                    data += (json_data[key1]?[i][key2])!+"\n"
                    
                    lbText.numberOfLines += 1

                }
            }
        }
        
        lbText.text = data
        
        
    }
}

