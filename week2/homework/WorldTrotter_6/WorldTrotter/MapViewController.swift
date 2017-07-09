//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by User on 2017. 7. 7..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit
import MapKit




class MapViewController: UIViewController , MKMapViewDelegate , CLLocationManagerDelegate {
    
    //MARK: loadView() 사용
    var mapView: MKMapView!
    //현재 위치를받기위해.
    
    let locationManager = CLLocationManager()
    let pinLocation = MKPointAnnotation()
    let secondPinLocation = MKPointAnnotation()
    let thirdPinLocation = MKPointAnnotation()
    
    
    
    
    
    
    //컨트롤러가 관리하는 뷰를 작성. 뷰를 수동으로 작성.
    override func loadView() {
        
        
        
        //지도 뷰 생성.
        mapView = MKMapView()
        mapView.delegate = self
        
        //현재위치 추가.
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
        
        
        //지도 뷰를 이 뷰 컨트롤러의 뷰로 설정
        self.view = mapView
        
        
        //segmentedcontrol 설정.
        
        let segmentedControl = UISegmentedControl(items: ["Stan" , "Hyb" , "Sat","송도","잠실","가든5","현위치"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged), for: .valueChanged)
        //기본 변환 설정 변경 불가.
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        //세그먼티드컨트롤 개체를 view 의 앞과 뒤의 간격과 같게 설정.
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8.0)
        
        let margins = view.layoutMarginsGuide // 8
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    
        
        

    }
    
    
    func mapTypeChanged(segControl: UISegmentedControl){
 
        let pinLocation = MKPointAnnotation()
        let secondPinLocation = MKPointAnnotation()
        let thirdPinLocation = MKPointAnnotation()
        
        //MARK: - FIRST PIN
        let location = CLLocationCoordinate2D(latitude: 37.392448, longitude: 126.638831)
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            pinLocation.coordinate = location
            pinLocation.title = "newCitySongdo"
        
        
        
        let secondLocation = CLLocationCoordinate2D(latitude: 37.512187, longitude: 127.099558)
        let secondRegion = MKCoordinateRegion(center: secondLocation, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            secondPinLocation.coordinate = secondLocation
            secondPinLocation.title = " JamsilLotteWorld"
        
        
        let thirdLocation = CLLocationCoordinate2D(latitude: 37.478504, longitude: 127.125550)
        let thirdRegion = MKCoordinateRegion(center: thirdLocation, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            thirdPinLocation.coordinate = thirdLocation
            thirdPinLocation.title = "Garden5, my Home"
        
        
        
     

        switch segControl.selectedSegmentIndex {
            
            
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        case 3:
            
            mapView.setRegion(region, animated: true)
            mapView.addAnnotation(pinLocation)
            
        case 4:
            mapView.setRegion(secondRegion, animated: true)
            mapView.addAnnotation(secondPinLocation)
        
        case 5:
            mapView.setRegion(thirdRegion, animated: true)
            mapView.addAnnotation(thirdPinLocation)
        case 6:
            locationManager.requestAlwaysAuthorization()
            locationManager.requestLocation()
            
        default:
            break
        }
        
        
        
       
    }
    
    
    
    
    //MARK: - Locations Delegate Method
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error:  \(error.localizedDescription) ")
    }
    
    //MARK: - Locations Delegate Method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        self.mapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
    }
 
    
    
    
    
}




