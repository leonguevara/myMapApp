//
//  ViewController.swift
//  myMapApp
//
//  Created by León Felipe Guevara Chávez on 2016-04-06.
//  Copyright © 2016 León Felipe Guevara Chávez. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    @IBOutlet var vistaNormal: [UIButton]!
    @IBOutlet weak var vistaSatélite: UIButton!
    @IBOutlet weak var vistaHíbrida: UIButton!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        mapa.zoomEnabled = true
        mapa.showsUserLocation = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

