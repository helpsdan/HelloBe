//
//  MapViewController.swift
//  HelloBe
//
//  Created by Daniel Aguiar on 20/9/18.
//  Copyright © 2018 Daniel Aguiar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class MapViewController: UIViewController {
    
    enum PlaceMessage{
        case message(String)
    }
    
    @IBOutlet weak var mapView: MKMapView!
    var num: Int = 0
    let locations = ["Cinema",
                     "Café",
                     "Parque",
                     "Restaurante",
                     "Praça",
                     "Livraria",
                     "Shopping"]
    var locationManage = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAuthorization()
        
        // Do any additional setup after loading the view.
    }
   
    override func viewDidAppear(_ animated: Bool) {
        let local = locations[num]
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(local) { (placemarks, error) in
            guard let placemark = placemarks?.first else { return }
            let latitude = placemark.location?.coordinate.latitude
            let longitude = placemark.location?.coordinate.longitude
            
        }
        showMessage(type: .message(local))
    }
    func savePlace(with placemark: CLPlacemark?) -> Bool{
        guard let placemark = placemark, let coordinate = placemark.location?.coordinate else { return false }
        return true
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        if num == 0{
            num += 1
        }else if num == 1{
            num += 1
        }else if num == 2{
            num += 1
        }else if num == 3{
            num += 1
        }else if num == 4{
            num += 1
        }else if num == 5{
            num += 1
        }else if num == 6{
            num = 0
        }
    }

    func showMessage(type: PlaceMessage){
        let title: String, message: String
        switch type {
            case .message(let name):
                title = "Selecionamos um local para você!"
                message = "Toque no local desejado e siga sua rota para ir ao \(name)."
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Prosseguir", style: .cancel, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil )
    }
    
    //Solicitando autorizacao do usuario para o uso da sua localizacao
    func requestAuthorization(){
        //definando a precissao da localizacao
        locationManage.desiredAccuracy = kCLLocationAccuracyBest
        
        //solicitando a autorizacao para o uso da localizacao ate mesmo quando o usuario sair da aplicacao
        locationManage.requestAlwaysAuthorization()
        
    }
}
