//
//  PlaceModal.swift
//  FavoritePlaces
//
//  Created by ysf on 11.11.21.
//


// Singleton -- burasda class icersinde olusturulan veriler her yerden cagrilabilir
import Foundation
import UIKit

class PlaceModal {
    static let sharedInstance = PlaceModal()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeLatitude = ""
    var placeLongitude = ""
    var placeImage = UIImage()
    
    private init(){}
}
