//
//  ProductVC.swift
//  MenuTask
//
//  Created by Shehata Gamal on 11/18/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit
import RealmSwift
class ProductVC: MainViewControllerS {

    var categroies = MenuViewModel()
    
    @IBOutlet weak var categoriesCV: UICollectionView!
    var res:RootCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
   
       categoriesCV.delegate = self
       
       categoriesCV.dataSource = self
       
       categoriesCV.register(UINib(nibName: "CateCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cell")
       

       categroies.start(self, params: [:])
         
        
    }

    func success(_ res:RootCategory) {
        
        print(res)
        
        self.res = res
        
        self.categoriesCV.reloadData()
    }

}



extension ProductVC :  UICollectionViewDelegate  , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         
        return res?.data.count ?? 0
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
        let wid = (self.view.frame.width  - 40 ) / 3
        
        print(wid)
        
        return CGSize(width:wid, height: wid)
       
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CateCollectionCell
          
             let item = res!.data[indexPath.row]
        
            cell.nameLbl.text = item.name
        
            return cell
            
    }

}
