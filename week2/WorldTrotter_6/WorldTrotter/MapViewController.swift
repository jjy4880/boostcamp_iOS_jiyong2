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
    
    //컨트롤러가 관리하는 뷰를 작성. 뷰를 수동으로 작성.
    override func loadView() {
        
        
        
        //지도 뷰 생성.
        mapView = MKMapView()
        mapView.delegate = self
        locationManager.delegate = self
        
        //지도 뷰를 이 뷰 컨트롤러의 뷰로 설정
        self.view = mapView
        
        
        //segmentedcontrol 설정.
        
        let segmentedControl = UISegmentedControl(items: ["Standard" , "Hybrid" , "Satellite"])
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
   
        
        
        //MARK: FirstAnnotation - Songdo CentralPark
        let location = CLLocationCoordinate2D(latitude: 37.392448, longitude: 126.638831)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "New City Song Do"
        annotation.subtitle = "CentralPark"
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        
        
        //MARK: SecondAnnotation - Jamsil - LotteWorld
        let secondLocation = CLLocationCoordinate2D(latitude: 37.512187, longitude: 127.099558)
        let secondAnnotation = MKPointAnnotation()
        secondAnnotation.coordinate = secondLocation
        secondAnnotation.title = "JamSil"
        secondAnnotation.subtitle = "LotteWorld"
        let secondSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let secondRegion = MKCoordinateRegion(center: secondLocation, span: secondSpan)
        

        
        
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
        mapView.setRegion(secondRegion, animated: true)
        mapView.addAnnotation(secondAnnotation)
        
        
        
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        print("MapViewController loaded its view")
    }
    
    func mapTypeChanged(segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
}
    
  
