//
//  AddPlaceVC.swift
//  FavoritePlaces
//
//  Created by ysf on 11.11.21.
//

import UIKit

class AddPlaceVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var placeNameText: UITextField!
    
    @IBOutlet weak var placeTypeText: UITextField!
    
    @IBOutlet weak var placeAtmasphereText: UITextField!
    

    @IBOutlet weak var placeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImageView.addGestureRecognizer(gestureRecognizer)


        
    }
    // PlaceModal isminde bir swift dosyasi ve icerinde bir class belierledik. bu class ta singleton yapisini kullandik. icerisinde olusturudugumuz verilere projenin her yerinden ulasabiliyoruz. Redux gibi ama daha kolay. Aslinda degiskenleri her hangi bir view controllerda globale yazsak ta diger sayfalardan ulasabiliriz. Ama bu sefer her veriye ulasmak cok kolay oluyor, cok guvenli degil
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if placeNameText.text != "" && placeTypeText.text != "" && placeAtmasphereText.text != "" {
            if let choosenImage = placeImageView.image {
                PlaceModal.sharedInstance.placeName = placeNameText.text!
                PlaceModal.sharedInstance.placeType = placeTypeText.text!
                PlaceModal.sharedInstance.placeAtmosphere = placeAtmasphereText.text!
                PlaceModal.sharedInstance.placeImage = choosenImage
                
            }
            performSegue(withIdentifier: "toMapVC", sender: nil)
        } else {
            let alert = UIAlertController(title: "ERROR!!", message: "Place name / Place type / Place atmosphere", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }

        
            }
    
    @objc func chooseImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
