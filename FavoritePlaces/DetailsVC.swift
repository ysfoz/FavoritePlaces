//
//  DetailsVC.swift
//  FavoritePlaces
//
//  Created by ysf on 11.11.21.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController, MKMapViewDelegate {

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
        
        mapView.delegate = self
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
                     
                     //ALL OBJECTS
                     
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
                     
                     // MAP
                     
                     let location = CLLocationCoordinate2D(latitude: self.choosenLatitude, longitude: self.choosenLongitude)
                     let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
                     let region = MKCoordinateRegion(center: location, span: span)
                     
                     self.mapView.setRegion(region, animated: true)
                     
                     let annotation = MKPointAnnotation()
                     annotation.coordinate = location
                     annotation.title = self.placeNameLabel.text!
                     annotation.subtitle = self.placeTypeLabel.text!
                     self.mapView.addAnnotation(annotation)
                     
                 }
             }
             
         }
     
        
    }
    
    // Annotation uzerindeki buttonu olusturabilmek icin
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        } else {
            let reuseId = "pin"
            
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
            
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView?.canShowCallout = true
                let button = UIButton(type: .detailDisclosure)
                pinView?.rightCalloutAccessoryView = button
            } else {
                pinView?.annotation = annotation
            }
            return pinView
            
        }
    }
    
// olusturulan buton ile kayitli yere navigation acabilmek icin
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.choosenLatitude != 0.0 && self.choosenLongitude !=  0.0 {
            let requestLocation = CLLocation(latitude: self.choosenLatitude, longitude: self.choosenLongitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { placemarks, error in
                if let placemark = placemarks {
                    if placemark.count > 0 {
                        
                        let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlaceMark)
                        mapItem.name = self.placeNameLabel.text
                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                        
                        mapItem.openInMaps(launchOptions: launchOptions)
                    }
                }
            }
        }
    }

}
