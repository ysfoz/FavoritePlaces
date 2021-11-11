//
//  DetailsVC.swift
//  FavoritePlaces
//
//  Created by ysf on 11.11.21.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var placeNameLabel: UILabel!
    
    @IBOutlet weak var placeAtmosphereLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var placeTypeLabel: UILabel!
    
    var choosenPlaceId = ""
    
    var choosenLatitude = Double()
    var choosenLongitude = Double()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromParse()
       
    }
    
    func getDataFromParse() {
        let query = PFQuery(className: "Places")
         query.whereKey("objectId", equalTo: choosenPlaceId)
         query.findObjectsInBackground { objects, error in
             if error != nil {
                 let alert = UIAlertController(title: "ERROR", message:error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                 let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                 alert.addAction(okButton)
                 self.present(alert, animated: true, completion: nil)
             } else {
                 if objects != nil {
                         let choosenObject = objects![0]
                     
                     if let placeName = choosenObject.object(forKey: "name") as? String {
                         self.placeNameLabel.text = placeName
                     }
                     if let typeName = choosenObject.object(forKey: "type") as? String {
                         self.placeTypeLabel.text = typeName
                     }
                     if let placeAtmosphere = choosenObject.object(forKey: "atmosphere") as? String {
                         self.placeAtmosphereLabel.text = placeAtmosphere
                     }
                     if let placeLatitude = choosenObject.object(forKey: "latitude") as? String {
                         if let placeLatitudeDouble = Double(placeLatitude) {
                             self.choosenLatitude = placeLatitudeDouble
                         }
                             
                     }
                     if let placeLongitude = choosenObject.object(forKey: "longitude") as? String {
                         if let placeLongitudeDouble = Double(placeLongitude) {
                             self.choosenLongitude = placeLongitudeDouble
                         }
                         
                     }
                     
                     if let imageData = choosenObject.object(forKey: "image") as? PFFileObject {
                         imageData.getDataInBackground { data, error in
                             if error == nil {
                                 if data != nil {
                                     self.imageView.image = UIImage(data: data!)
                                 }
                                 
                             }
                         }
                     }
                     
                 }
             }
             
         }
     
        
    }
    


}
