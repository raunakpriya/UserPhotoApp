//
//  DetailViewController.swift
//  UserPhotoApp
//
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var myImageView2: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var photoContent: photo = photo(name: "", email: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myImageView2.image = UIImage(named: "emptyImage")
        nameLabel.text = photoContent.name
        addressLabel.text = photoContent.email

    }

}
