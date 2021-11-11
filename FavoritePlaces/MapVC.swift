//
//  MapVC.swift
//  FavoritePlaces
//
//  Created by ysf on 11.11.21.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(cancelButtonClicked))
    }
    

    @objc func saveButtonClicked() {
        
    }
    
    @objc func cancelButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }

}
