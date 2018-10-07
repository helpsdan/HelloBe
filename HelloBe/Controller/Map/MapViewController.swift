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
    
    var place: Place!
    @IBOutlet weak var mapView: MKMapView!
    var num: Int = 0
    let locations = ["Av. Paulista, 1578 ",
                     "R. da Consolação, 94",
                     "R. Treze de Maio, 1947",
                     "R. Frei Caneca, 569",
                     "R. Brg. Jordão, 149",
                     "R. Apeninos, 118",
                     "Praça da Luz, 2",
                     "Av. Europa, 158"]
    var locationManage = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAuthorization()
        
        self.mapView.showsUserLocation = true
        self.mapView.userTrackingMode = .follow
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let local = locations[num]
        let geoCoder = CLGeocoder()
        let request = MKLocalSearch.Request()
        request.region = self.mapView.region
        
        geoCoder.geocodeAddressString(local) { (placemarks, error) in
            guard let placemark = placemarks?.first, let coordinate = placemark.location?.coordinate else { return }
            self.place = Place(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let region = MKCoordinateRegion.init(center: coordinate, latitudinalMeters: 300, longitudinalMeters: 300)
            self.mapView.setRegion(region, animated: true)
            let annotation = MKPointAnnotation()
            annotation.coordinate = self.place.coordinate
            self.mapView.addAnnotation(annotation)
        }
        showMessage(type: .message(local))
        
        
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
            num += 1
        }else if num == 7{
            num = 0
        }
    }
    
    func showMessage(type: PlaceMessage){
        let title: String
        var message: String
        switch type {
        case .message(let name):
            title = "Selecionamos um local para você!"
            message = ""
            if num == 0{
                message += "MASP"
            }else if num == 1{
                message += "Biblioteca Mario de Andrade"
            }else if num == 2{
                message += "Shopping Pátio Paulista"
            }else if num == 3{
                message += "Teatro Shopping Frei Caneca"
            }else if num == 4{
                message += "Museu do Ipiranga"
            }else if num == 5{
                message += "Teatro Santo Agostinho"
            }else if num == 6{
                message += "Pinacoteca do Estado de São Paulo"
            }else if num == 7{
                message += "Museu da Imagem e do Som"
            }
            
            let _ = name
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




