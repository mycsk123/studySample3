//
//  ViewController.swift
//  JSON_MapSample
//
//  Created by kwon on 28/07/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var myMap: MKMapView!
    
    
    @IBOutlet weak var tfSearchYearCd: UITextField!
    
    @IBOutlet weak var tfsiDo: UITextField!
    
    @IBOutlet weak var tfguGun: UITextField!
    
    
    @IBOutlet weak var lbText: UILabel!
    
    let locationManager:CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        //정확도를 최고로 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //위치 데이터를 추적하기 위해 사용자에게 승인 요구
        locationManager.requestWhenInUseAuthorization()
        //위치 업데이트
        locationManager.startUpdatingLocation()
        //위치 보기 값 설정
        myMap.showsUserLocation = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func btnJsonGet(_ sender: UIButton) {
        getFromJSON()
    }
    
    func goLocation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D{
        
        //지도를 나타내기 위해 4개의 함수 호출
        let pLocation = CLLocationCoordinate2D(latitude: latitudeValue, longitude: longitudeValue)
        let sapnValue = MKCoordinateSpanMake(span, span)
        let pRegion = MKCoordinateRegionMake(pLocation, sapnValue)
        myMap.setRegion(pRegion, animated: true)
        
        return pLocation
    }
    
    //특정 위도와 경도에 핀 설치
    func setAnnotation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubtitle: String){
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitude: latitudeValue, longitude: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        
        myMap.addAnnotation(annotation)
        
    }
    
    
    
    func getFromJSON() {

        //텍스트 필드값을 받아 url 저장
        let searchYearCd:String = tfSearchYearCd.text! //년도코드
        var siDo:String = tfsiDo.text! //법정동시도코드
        var guGun:String = tfguGun.text! //법정동시군구코드
        
        let tempUrl: String = "http://apis.data.go.kr/B552061/jaywalking/getRestJaywalking?serviceKey=slg7RJ8L%2FCOauR%2FaIz85i2dqPOIbESUB2oT83luBfprZZQy5C5t9gdyOn7FwwPFHMAMpgwZadPce0vCiDFiQLg%3D%3D&searchYearCd=\(searchYearCd)&sido=\(siDo)&gugun=\(guGun)"

        // 다운받을 json의 url경로 문자열(string)->URL타입으로 생성
        let url: URL? = URL(string: tempUrl)
        
        // 생성한 url로 url요청을위한 request를 생성
        let request : URLRequest? = URLRequest(url: url!)
        
        // url로 다운받기 위해 task(작업) 생성
        let task = URLSession.shared.dataTask(with: request!) {
            data, reponse, error in
            
            if (error == nil) {
                if (data != nil) {
                    
                    let httpStatus : HTTPURLResponse = reponse as! HTTPURLResponse
                    
                    if httpStatus.statusCode == 200 {
                        
                        // JSON데이터를 파싱하여, NSDictionary타입으로 반환함.
                        let responseDic = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                        
                        let searchResult = responseDic["searchResult"] as! NSDictionary
                        
                        let frequentzon = searchResult["frequentzone"] as! [AnyObject]
                        
                        let frequentzon2Dic = frequentzon[0] as! NSDictionary
                        
                        let spotname = frequentzon2Dic["spotname"] as! AnyObject
                        
                        let xcrd = frequentzon2Dic["x_crd"] as! AnyObject
                        let ycrd = frequentzon2Dic["y_crd"] as! AnyObject
                        
                        //geometry는 json 형식을 띈 문자열
                        let geometry = frequentzon2Dic["geometry"] as! AnyObject
                        
                        let geometryDic = try! JSONSerialization.jsonObject(with: geometry.data(using: 0)!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                        
                        let coordinates = geometryDic["coordinates"] as! [AnyObject]
                        
                        //locatio 41개 배열 안에 또 배열(2차원 배열)
                        let location = coordinates[0] as! [AnyObject]
                        
                        // 지금 진행중인 작업(task)와 동기적으로 작동되도록 하는 코드
                        DispatchQueue.main.sync {
                            // 메인해당되는
                            // ViewController와 연동해서 작업할것.
                            
                            var texts = String(describing: spotname)
                            self.lbText.text = texts
                            
                            for i in 0..<location.count{
                                
                                //위 경도값 반대로 입력해야 함
                                var tempX = location[i][0] as! Double
                                var tempY = location[i][1] as! Double

                                self.setAnnotation(latitude: tempY, longitude: tempX, delta: 0.01, title: "", subtitle: "")

                            }

                        }
                        
                    }
                    
                }
            }
        }
        // 생성한 task를 실행
        task.resume()
    }


}

