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
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManage = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Mostrar localizacao do usuario
        mapView.showsUserLocation = true
        
        
        //Rastrear a localizacao do usuario
        mapView.userTrackingMode = .follow
        
        
        //Definindo a delegate
        mapView.delegate = self
        
        
        
        //Definindo o delegate
        
        //searchBar.delegate = self
        
        
        requestAuthorization()
        
        // Do any additional setup after loading the view.
    }
    
    //Solicitando autorizacao do usuario para o uso da sua localizacao
    func requestAuthorization(){
        //definando a precissao da localizacao
        locationManage.desiredAccuracy = kCLLocationAccuracyBest
        
        //solicitando a autorizacao para o uso da localizacao ate mesmo quando o usuario sair da aplicacao
        locationManage.requestAlwaysAuthorization()
        
    }
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
extension MapViewController: UISearchBarDelegate{
    
    //Implementando metodo disparado pelo botao search da searchBar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Retirando foco da SearchBar(Escondendo o teclado)
        searchBar.resignFirstResponder()
        
        
        //Criando objeto que configura uma pesquisa de pontos  de interrese
        let request = MKLocalSearchRequest()
        
        
        //Configurando a regiao do mapa onde a pesquisa sera feita
        request.region = mapView.region
        
        //Definindo o que sera pesquisado
        
        request.naturalLanguageQuery = searchBar.text
        
        
        let search = MKLocalSearch(request: request)
        
        
        //Realizar a pesquisa
        
        search.start { (response, error) in
            if error == nil{//nao teve erro
                guard let response = response else {return}
                
                
                //Remover as annotation previamente adicionadas
                self.mapView.removeAnnotations(self.mapView.annotations)
                
                
                //Varrer todos os pontos de interesse da pesquisa
                for item in response.mapItems{
                    //Criando uma annotation
                    let annotation = MKPointAnnotation()
                    
                    //Definir a Lat e Long da annotation
                    annotation.coordinate = item.placemark.coordinate
                    
                    //Definir titulo e sub-titulo da annotation
                    annotation.title = item.name
                    annotation.subtitle = item.url?.absoluteString
                    
                    //Adicionando annotation no mapa
                    self.mapView.addAnnotation(annotation)
                    
                    
                    
                }
                
                
            }
        }
        
    }
}
extension MapViewController : MKMapViewDelegate{
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) ->
        MKOverlayRenderer {
            
            if overlay is MKPolyline{
                let renderer = MKPolylineRenderer(overlay: overlay)
                
                renderer.lineWidth = 7.0
                renderer.strokeColor = .green
                
                
                return renderer
                
            }else {
                return MKOverlayRenderer(overlay: overlay)
            }
            
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        //Criando um objeto de configuracao da requisicao de rota
        let request = MKDirectionsRequest()
        
        //Configurar origem e destino da rota
        //origem
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: mapView.userLocation.coordinate))
        //destino
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: view.annotation!.coordinate))
        
        
        //Criando o objeto que calcula a rota
        let directions = MKDirections(request: request)
        
        //Calcular a rota
        directions.calculate { (response, error) in
            if error == nil{
                guard let response = response else {return}
                
                //Recuperando a rota
                guard let route = response.routes.first else {return}
                
                //Apagando rotas anteriores
                self.mapView.removeOverlays(self.mapView.overlays)
                
                //Adicionando a rota
                self.mapView.add(route.polyline, level: .aboveRoads)
            }
        }
        
        
    }
}
