//
//  ViewController.swift
//  Chap08_DoitMission
//
//  Created by kwon on 28/07/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var myMap: MKMapView!
    
    @IBOutlet weak var lbLocationinfo1: UILabel!
    
    @IBOutlet weak var lbLocationinfo2: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        lbLocationinfo1.text = ""
        lbLocationinfo2.text = ""
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
    
    //위도와 경도, 영역 폭을 입력받아 지도에 표시
    func goLocation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D{
        
        //지도를 나타내기 위해 4개의 함수 호출
        let pLocation = CLLocationCoordinate2D(latitude: latitudeValue, longitude: longitudeValue)
        let sapnValue = MKCoordinateSpanMake(span, span)
        let pRegion = MKCoordinateRegionMake(pLocation, sapnValue)
        myMap.setRegion(pRegion, animated: true)
        
        return pLocation
    }
    
    func setAnnotation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubltitle: String) {
        //핀을 설치하기 위한 MKPointAnnotation 호출
        let annotiation = MKPointAnnotation()
        annotiation.coordinate = goLocation(latitude: latitudeValue, longitude: longitudeValue, delta: span)
        
        annotiation.title = strTitle
        annotiation.subtitle = strSubltitle
        
        myMap.addAnnotation(annotiation)
    }
    
    //위치 정보에서 국가, 지역, 도로를 추출하여 레이블에 표시
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        goLocation(latitude: (pLocation?.coordinate.latitude)!, longitude: (pLocation?.coordinate.longitude)!, delta: 0.01)
        
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            
            (placemarks, error) -> Void in
            
            let pm = placemarks!.first
            let country = pm?.country
            var address: String = country!
            
            //지역값
            if pm?.locality != nil{
                address += ""
                address += pm!.country!
            }
            //도로값
            if pm?.thoroughfare != nil{
                address += ""
                address += (pm?.thoroughfare)!
            }
            
            self.lbLocationinfo1.text = "현재 위치"
            self.lbLocationinfo2.text = address
            
        })
        
        locationManager.stopUpdatingLocation()
        
    }

    
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        
        //세그먼트 컨트롤에서 만든 메뉴 개수만큼 인덱스값을 보유
        if sender.selectedSegmentIndex == 0{
            self.lbLocationinfo1.text = ""
            self.lbLocationinfo2.text = ""
            locationManager.startUpdatingLocation()
        }
        else if sender.selectedSegmentIndex == 1{
            setAnnotation(latitude: 37.751853, longitude: 128.87605740000004, delta: 1, title: "강릉폴리텍", subtitle: "강원도 강릉시 남산초교길 121")
            self.lbLocationinfo1.text = "보고 계신 위치"
            self.lbLocationinfo2.text = "강릉 폴리텍"
        }
        else if sender.selectedSegmentIndex == 2{
            setAnnotation(latitude: 37.5307871, longitude: 126.8981, delta: 0.1, title: "이지스퍼블리싱", subtitle: "서울시 영등포구 당산로 41길 11")
            self.lbLocationinfo1.text = "보고 계신 위치"
            self.lbLocationinfo2.text = "이지스퍼블리싱 출판사"
        }
        else if sender.selectedSegmentIndex == 3{
            
            setAnnotation(latitude: 35.173139, longitude: 129.071270, delta: 0.1, title: "양정역", subtitle: "부산광역시 양정2동")
            self.lbLocationinfo1.text = "보고 계신 위치"
            self.lbLocationinfo2.text = "양정역"
        }
    }


}

