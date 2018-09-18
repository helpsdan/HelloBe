//
//  MapViewController.swift
//  HelloBe
//
//  Created by Usuário Convidado on 14/09/2018.
//  Copyright © 2018 Daniel Aguiar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    var locationManage = CLLocationManager()
    let number = Int(arc4random_uniform(6))
    
    var locations = ["Café","Parque","Cinema","Academia", "Restaurante"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Mostrar a localizacao do usuario
        mapView.showsUserLocation = true
        //Rastrear a localizacao do usuario
        mapView.userTrackingMode = .follow
        // Definindo o delegate do mapview
        mapView.delegate = self
        //Define a delegate (classe que responde) da SearchBar
        searchBar.delegate = self
        requestAuthorization()
    }

    
    
    //Solicitando autorizacao do usuario para o uso da sua localizacao
    func requestAuthorization(){
        // defininco a precisao da localizacao do usuario
        locationManage.desiredAccuracy = kCLLocationAccuracyBest
        // solicitando autorizacao para uso da localizacao com o app em uso
        locationManage.requestWhenInUseAuthorization()
    }

    //Implementando método disparado pelo botao search da search bar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // retirando o foco da searchBar (Esconder o teclado)
        searchBar.resignFirstResponder()
        // Criando objeto que configura uma pesquisa de pontos de interese
        let request = MKLocalSearchRequest()
        // Configurando a região do mapa onde a pesquisa sera feita
        request.region = mapView.region
        // Definindo o que sera buscado
        request.naturalLanguageQuery = "Café"
        // criando objeto que realiza a pesquisa
        let search = MKLocalSearch(request: request)
        // realizando a pesquisa
        search.start { (response, error) in
            if error == nil { //Não teve erro na pesquisa
                guard let response = response else {return}
                // remover as anotations previamente adicionadas
               //self.mapView.removeAnnotations(self.mapView.annotations)
                // varrer todos os pontos de interesse trazidos pela pesquisa
                for item in response.mapItems{
                    // criando uma annotation
                    let annotation = MKPointAnnotation()
                    //definindo a latitude e a longitude da annotation
                    annotation.coordinate = item.placemark.coordinate
                    // definindo um titulo e subtitulo da annotation
                    annotation.title = item.name
                    annotation.subtitle = item.url?.absoluteString
                    
                    // Adicionar annotation no mapa
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) ->
        MKOverlayRenderer {
            if overlay is MKPolyline {
                let renderer = MKPolylineRenderer(overlay: overlay)
                
                renderer.lineWidth = 3.0
                renderer.strokeColor = .blue
                
                return renderer
            }else{return MKOverlayRenderer(overlay: overlay)}
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // Criando um objeto de configuracao da requisicao de rota
        let request = MKDirectionsRequest()
        
        // configura a origem e o destino da rota
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: mapView.userLocation.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: view.annotation!.coordinate))
        
        // criando objeto que realiza o calculo da rota
        let directions = MKDirections(request: request)
        
        // Calcular a rota
        directions.calculate { (response, error) in
            if error == nil{//nao deu erro
                guard let response = response else {return}
                //recuperando a rota
                guard let route = response.routes.first else {return}
                
                //Passo a passo da rota
                for step in route.steps{
                    print(step.distance)
                }

                //apagar as rotas anteriores
                self.mapView.removeOverlays(self.mapView.overlays)
                
                // adicionar a rota no mapa
                self.mapView.add(route.polyline, level: .aboveRoads)
            }
        }
    }
    
}













