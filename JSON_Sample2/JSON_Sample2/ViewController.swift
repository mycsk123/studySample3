//
//  ViewController.swift
//  JSON_Sample2
//
//  Created by kwon on 26/07/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func btnGetJSON(_ sender: UIButton) {
        getFromJSON()
    }
    
    func getFromJSON(){
        //다운받을 json의 url경로 문자열() -> URL 타입으로 생성
        let url: URL = URL(string: "http://121.176.157.227/pizza.json")!
        //생성한 url로 url요청을 위한 request 생성
        let request: URLRequest = URLRequest(url: url)
        
        //비동기
        let task = URLSession.shared.dataTask(with: request){
            data, reponse, error in
            
            if(error == nil)
            {
                if(data != nil)
                {
                    let httpStatus: HTTPURLResponse = reponse as! HTTPURLResponse
                    
                    //statuscode 의미는?
                    if httpStatus.statusCode == 200{
                        let responseString = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                        
                        let menus = responseString["menu"] as! [AnyObject]
                        
                        var object: [AnyObject?] = [AnyObject?]()
                        
                        for i in 0..<menus.count{
                           let menu = menus[i] as! NSDictionary
                            
                        object.append(menu["id"] as! AnyObject)
                            object.append(menu["name"] as! AnyObject)
                            object.append(menu["cost"] as! AnyObject)
                            object.append(menu["description"] as! AnyObject)

                        }
                        
                        DispatchQueue.main.sync {
                            //메인에 해당하는
                            //viewcontroller와 연동해서 작업
                            
                            var texts = ""
                            
                            for i in 0..<object.count{
                                texts += String(describing: object[i]!) + "\n"
                                self.lbText.numberOfLines += 1
                            }
                            
                            self.lbText.text = texts
                        }
                    }
                }
            }
            
        }
        
        task.resume()
        
    }
}

