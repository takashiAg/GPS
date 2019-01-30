//
//  ViewController.swift
//  running
//
//  Created by ryosukeando on 2019/01/28.
//  Copyright © 2019 ryosukeando. All rights reserved.
//
//
import UIKit
import RxSwift
import RxCocoa

import CoreLocation
import CoreMotion

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    var lat:Double = 0
    var lng:Double = 0
    
    var locationManager: CLLocationManager!
    let motionManager = CMMotionManager()
    @IBOutlet weak var latTextField: UITextField!
    @IBOutlet weak var lngTextField: UITextField!
    @IBOutlet weak private var button: UIButton!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        button.rx.tap
//            .subscribe({ _ in
//                print("did push")
//            })
//            .disposed(by: disposeBag)
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self as! CLLocationManagerDelegate
            locationManager.startUpdatingLocation()
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last,
            CLLocationCoordinate2DIsValid(newLocation.coordinate) else {
                self.latTextField.text = "Error"
                self.lngTextField.text = "Error"
                return
        }
        
        self.latTextField.text = "".appendingFormat("%.4f", newLocation.coordinate.latitude)
        lat = newLocation.coordinate.latitude
        self.lngTextField.text = "".appendingFormat("%.4f", newLocation.coordinate.longitude)
        lng = newLocation.coordinate.longitude
    }
}
//import UIKit
//import CoreLocation
//import CoreMotion
//
//
//class ViewController: UIViewController, CLLocationManagerDelegate {
//
//    var lat:Double = 0
//    var lng:Double = 0
//
//    var locationManager: CLLocationManager!
//    let motionManager = CMMotionManager()
//
//    @IBOutlet weak var latTextField: UITextField!
//    @IBOutlet weak var lngTextField: UITextField!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager = CLLocationManager()
//            locationManager.delegate = self as! CLLocationManagerDelegate
//            locationManager.startUpdatingLocation()
//        }
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        switch status {
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        case .restricted, .denied:
//            break
//        case .authorizedAlways, .authorizedWhenInUse:
//            break
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let newLocation = locations.last,
//            CLLocationCoordinate2DIsValid(newLocation.coordinate) else {
//                self.latTextField.text = "Error"
//                self.lngTextField.text = "Error"
//                return
//        }
//
//        self.latTextField.text = "".appendingFormat("%.4f", newLocation.coordinate.latitude)
//        lat = newLocation.coordinate.latitude
//        self.lngTextField.text = "".appendingFormat("%.4f", newLocation.coordinate.longitude)
//        lng = newLocation.coordinate.longitude
//    }
//
//}
