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
  
       setData(selectedCate!)
        
    }
    
    func setData(_ res:Category) {
        
        print(res)
          
        allPages = res.content.chunked(into: 20)
         
        currentPage = allPages.first ?? []
        
        self.productsCV.reloadData()
        
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

