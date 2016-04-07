//
//  ViewController.swift
//  myMapApp
//
//  Created by León Felipe Guevara Chávez on 2016-04-06.
//  Copyright © 2016 León Felipe Guevara Chávez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    
    private var locManager : CLLocationManager!
    private var posicion : CLLocation!
    private var distancia : Double = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locManager = CLLocationManager()
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
        mapa.showsUserLocation = true
        
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Obtengo la posición actual de dispositivo
        let userLocation:CLLocation = locations[0]
        
        // Utilizo la posición actual para definir la región que se mostrará en el mapa, usando un
        // delta de 0.02 grados tanto en la latitud como en la longitud.  Esto hace que el zoom sobre
        // el mapa sea fijo
        let latitude:CLLocationDegrees = userLocation.coordinate.latitude
        let longitude:CLLocationDegrees = userLocation.coordinate.longitude
        let latDelta:CLLocationDegrees = 0.02
        let lonDelta:CLLocationDegrees = 0.02
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        mapa.setRegion(region, animated: false)

        if posicion == nil {
            posicion = userLocation
            distancia = 0
            anotarEnElMapa()
        } else {
            let distanciaActual = userLocation.distanceFromLocation(posicion)
            let distanciaEntera = floor(distanciaActual)
            if distanciaEntera >= 50 {
                distancia += 50
                posicion = userLocation
                anotarEnElMapa()
            }
        }
    }
    
    func anotarEnElMapa() {
        let titulo : String = "(\(posicion.coordinate.longitude), \(posicion.coordinate.latitude))"
        let subtitulo : String = "Distancia: \(distancia) mts."
        
        let annotation = MKPointAnnotation()
        annotation.title = titulo
        annotation.subtitle = subtitulo
        annotation.coordinate = posicion.coordinate
        mapa.addAnnotation(annotation)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        let alerta = UIAlertController(title: "Error", message: "Error: \(error.code)", preferredStyle: .Alert)
        let accionOK = UIAlertAction(title: "OK", style: .Default) { (accion) -> Void in
            //..
        }
        alerta.addAction(accionOK)
        self.presentViewController(alerta, animated: true, completion: nil)
    }
    
    @IBAction func cambiarVista(sender: UIButton) {
        if (sender.tag == 1) {
            // Seleccionó la vista normal
            mapa.mapType = .Standard
        } else if (sender.tag == 2) {
            // Seleccionó la vista satelital
            mapa.mapType = .Satellite
        } else {
            // Seleccionó la vista híbrida
            mapa.mapType = .Hybrid
        }
    }

}

