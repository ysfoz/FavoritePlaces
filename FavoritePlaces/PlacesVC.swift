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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logaut", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logautButtonClicked))
    }
    
    @objc func addButtonClicked() {
        
    }
    
    @objc func logautButtonClicked() {
        PFUser.logOutInBackground { error in
            if error != nil {
                let alert = UIAlertController(title: "ERROR!", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier:"toSignInVC", sender: nil)
            }
                    
                
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
    
        return cell
    }
    
   
    
    
    

}
