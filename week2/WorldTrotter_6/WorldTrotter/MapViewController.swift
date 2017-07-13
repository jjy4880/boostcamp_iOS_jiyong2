//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by User on 2017. 7. 7..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController, CLLocationManagerDelegate , MKMapViewDelegate {
    
    //MARK: loadView() 사용
    var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    //컨트롤러가 관리하는 뷰를 작성. 뷰를 수동으로 작성.
    override func loadView() {
        //지도 뷰 생성.
        mapView = MKMapView()
        
        
        mapView.delegate = self
        
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
        
       
        
        //지도 뷰를 이 뷰 컨트롤러의 뷰로 설정
        self.view = mapView
        
        
        //segmentedcontrol 설정.
        
        let segmentedControl = UISegmentedControl(items: ["Stan" , "Hyb" , "Sate","신도시","잠실","학교","현위치"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged), for: .valueChanged)
        
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
        
        //
        let zoomButton: UIButton = UIButton(type: UIButtonType.roundedRect)
        zoomButton.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        zoomButton.backgroundColor = UIColor.green
        zoomButton.setTitle("확대" , for: .normal)
        zoomButton.translatesAutoresizingMaskIntoConstraints = false
        
        zoomButton.addTarget(self, action: #selector(zoomLocation), for: .touchUpInside)
        
        view.addSubview(zoomButton)
        
        let leadingOfZoomButton = zoomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let bottomOfZoomButton = zoomButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
        let widthOfZoomButton = zoomButton.widthAnchor.constraint(equalToConstant: zoomButton.bounds.width)
        let heightOfZoomButton = zoomButton.heightAnchor.constraint(equalToConstant: zoomButton.bounds.height)
        
        leadingOfZoomButton.isActive = true
        bottomOfZoomButton.isActive = true
        widthOfZoomButton.isActive = true
        heightOfZoomButton.isActive = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view")
    }
    
    func mapTypeChanged(segControl: UISegmentedControl){
        
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
        let secondRegion = MKCoordinateRegion(center: secondLocation, span: span)
        
        
        //MARK: ThirdAnnotation - SuwonUniv.
        
        let thirdLocation = CLLocationCoordinate2D(latitude: 37.209014,  longitude: 126.976634)
        let thirdAnnotation = MKPointAnnotation()
        thirdAnnotation.coordinate = thirdLocation
        thirdAnnotation.title = "수원대학교"
        let thirldRegion = MKCoordinateRegion(center: thirdLocation, span: span)
       
        
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        case 3:
            mapView.setRegion(region, animated: true)
            mapView.addAnnotation(annotation)
            
        case 4:
            mapView.setRegion(secondRegion, animated: true)
            mapView.addAnnotation(secondAnnotation)
            
        case 5:
            mapView.setRegion(thirldRegion, animated: true)
            mapView.addAnnotation(thirdAnnotation)
        case 6:
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
            
        default:
            break
        }
    }
    
    // MARK: - Location Delegate Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        self.mapView.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error:  \(error.localizedDescription)" , terminator: "")
    }
    


    func zoomLocation() {
        let userLocation = mapView.userLocation
        let region = MKCoordinateRegionMakeWithDistance((userLocation.location?.coordinate)!, 200 , 200)
        mapView.setRegion(region, animated: true)
    }
    
    
    
    
}
