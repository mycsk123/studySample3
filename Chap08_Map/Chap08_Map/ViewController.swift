//
//  ViewController.swift
//  Chap08_Map
//
//  Created by kwon on 26/07/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    //mapkit 추가
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
    
    func goLocation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue: CLLocationDegrees, delta span: Double){
        
        //지도를 나타내기 위해 4개의 함수 호출
        let pLocation = CLLocationCoordinate2D(latitude: latitudeValue, longitude: longitudeValue)
        let sapnValue = MKCoordinateSpanMake(span, span)
        let pRegion = MKCoordinateRegionMake(pLocation, sapnValue)
        myMap.setRegion(pRegion, animated: true)
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        goLocation(latitude: (pLocation?.coordinate.latitude)!, longitude: (pLocation?.coordinate.longitude)!, delta: 0.01)
        
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
        
            (placemarks, error) -> void in
            let pm = placemarks!.first
            let country = pm.country
            var address: String = country
            
            if pm.locality != nil{
                address += ""
                address += pm.country
            }
            
        })
        
    }

    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
    }

}

