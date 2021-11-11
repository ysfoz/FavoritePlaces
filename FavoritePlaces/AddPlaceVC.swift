//
//  AddPlaceVC.swift
//  FavoritePlaces
//
//  Created by ysf on 11.11.21.
//

import UIKit

class AddPlaceVC: UIViewController {
    @IBOutlet weak var placeNameText: UITextField!
    
    @IBOutlet weak var placeTypeText: UITextField!
    
    @IBOutlet weak var placeAtmasphereText: UITextField!
    
    @IBOutlet weak var placeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toMapVC", sender: nil)
        
    }
    
    

}
