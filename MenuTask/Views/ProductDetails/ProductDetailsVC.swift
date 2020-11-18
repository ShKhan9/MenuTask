//
//  ProductDetailsVC.swift
//  MenuTask
//
//  Created by MacBook Pro on 11/18/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController {

    // outlets from IB
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var closeBu: UIButton!
    
    // get products from server
    var product:ProductModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // icon image from FontAwesome
        self.closeBu.setTitle(String(format:"%C",0xf057), for: .normal)
        
        // configure popup from product details
        nameLbl.text = product.name
        priceLbl.text = "\(product.price)" + " L.E"
        img.sd_setImage(with: URL(string:product.image ?? "" ), placeholderImage: UIImage(named: "placeholder.png"))

        // round the view
        backView.layer.cornerRadius = 30
        backView.clipsToBounds = true
    }
    
    // close button action to dismiss the vc
    @IBAction func closeClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
