//
//  PlacesVC.swift
//  FavoritePlaces
//
//  Created by ysf on 11.11.21.
//

import UIKit
import Parse

class PlacesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    var placeNamaArray = [String]()
    var placeIdArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logaut", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logautButtonClicked))
        
        getDataFromParse()
    }
    
    func getDataFromParse() {
        
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { objects, error in
            if error != nil {
                self.makeAlert(title: "ERROR!!", message: error?.localizedDescription ?? "ERROR!!")
            } else {
                if objects != nil {
                    self.placeIdArray.removeAll(keepingCapacity: false)
                    self.placeIdArray.removeAll(keepingCapacity: false)
                    
                    for object in objects! {
                        if let placeName =  object.object(forKey: "name") as? String {
                            if let placeId = object.objectId as? String{
                                self.placeNamaArray.append(placeName)
                                self.placeIdArray.append(placeId)
                            }
                        }
                    }
                    self.tableView.reloadData()
                    
                }
            }
        }
        
    }
    
    @objc func addButtonClicked() {
        performSegue(withIdentifier: "toAddPlaceVC", sender: nil)
    }
    
    
    
    @objc func logautButtonClicked() {
        PFUser.logOutInBackground { error in
            if error != nil {
                self.makeAlert(title: "ERROR!!", message: error!.localizedDescription ?? "ERROR!!")
            } else {
                self.performSegue(withIdentifier:"toSignInVC", sender: nil)
            }
                    
                
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeIdArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNamaArray[indexPath.row]
        return cell
    }
    
    func makeAlert(title: String , message: String) {
        let alert = UIAlertController(title: title, message:message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
   
    
    
    

}
