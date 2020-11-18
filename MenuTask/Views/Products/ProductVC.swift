//
//  ProductVC.swift
//  MenuTask
//
//  Created by Shehata Gamal on 11/18/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit
import RealmSwift
import SDWebImage
import Lottie

class ProductVC: MainViewControllerS {
 
    // IB Outlets
    @IBOutlet weak var productsCV: UICollectionView!
    
    @IBOutlet weak var backBu: UIButton!
    
    @IBOutlet weak var namelb: UILabel!
    
    // send data from ProductVC to menuVC
    weak var delegate:PassingManager?
    
    // get products for a category from server
    var products = ProductViewModel()
     
    // passed category from the previous vc
    var selectedCate:Category!
     
    // dataSource of collection = all products
    var res:RootProduct?
    
    // current page categories
    var currentPage = [ProductModel]()
    
    // hold all categories
    var allPages = [[ProductModel]]()
    
    // prev - next moving needle
    var needle = 0
      
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
   
        self.backBu.setTitle(String(format:"%C",0xf053), for: .normal)
        
        namelb.text = selectedCate?.name
        
       productsCV.delegate = self
       
       productsCV.dataSource = self
       
       productsCV.register(UINib(nibName: "ProductCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cell")
 
       readStored()
        
    }
    
    // check if we requested products of that category before
    
    func readStored() {
         
        if let res = selectedCate.content {
            
            self.success(res)
        }
        else {

            getProducts()
            
        }
         
    }
    
    // get products
    
    func getProducts() {
        
         
        if Utilities.noNetwork() {
            
            noInternet()
        }
        else {
             
            products.start(self,name:selectedCate!.id, params: [:])
            
        }
        
        
    }

    // success part of getting products
    
    func success(_ res:RootProduct) {
        
        print(res)
        
        self.res = res
        
        allPages = self.res?.data.chunked(into: 20) ?? []
         
        currentPage = allPages.first ?? []
        
        let realm = try! Realm()
        
        try! realm.write {
            
               selectedCate?.content = res
        }
        
        self.productsCV.reloadData()
         
    }
    
     // fail part of getting data
    
    func fail() {
        
        let alert = UIAlertController(title: "Error Message", message: "Problem downloading data", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "ReTry", style: .default, handler: { (act) in
            self.getProducts()
        }))
        self.present(alert, animated: true, completion: nil)
         
    }
    
     // No internet connection
    
    func noInternet() {
        
        let alert = UIAlertController(title:nil , message: "No internet connection", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "ReTry", style: .default, handler: { (act) in
            self.getProducts()
        }))
        self.present(alert, animated: true, completion: nil)
         
    }
    
    // previous button click
    
    @IBAction func prevClicked(_ sender: Any) {
        
        if needle - 1 >= 0 {
            
            needle -= 1
            
            currentPage = allPages[needle]
            
            productsCV.reloadData()
            
        }
         
    }
    
    // next button click
    
    @IBAction func nextClicked(_ sender: Any) {
        
        if needle + 1 < allPages.count {
            
            needle += 1
            
            currentPage = allPages[needle]
            
            productsCV.reloadData()
            
        }

    }
    
    // Action when back button is clicked to pop the vc
    
    @IBAction func backClicked(_ sender: Any) {

        self.navigationController?.popViewController(animated: true)
         
    }
    
    
    
    

}


// implement dataSource & delegate of the collection

extension ProductVC :  UICollectionViewDelegate  , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         
        return currentPage.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
        let wid = (self.view.frame.width  - 40 ) / 3
        
        print(wid)
        
        return CGSize(width:wid, height: wid)
       
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCollectionCell
          
             let item = currentPage[indexPath.row]
        
            cell.nameLbl.text = item.name
        
            cell.img.sd_setImage(with: URL(string:item.image ?? "" ), placeholderImage: UIImage(named: "placeholder.png"))
              
            return cell
            
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          
        delegate?.selected(currentPage[indexPath.row])
    }

}

