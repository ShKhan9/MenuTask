//
//  MenuVC.swift
//  MenuTask
//
//  Created by Shehata Gamal on 11/18/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit
import RealmSwift
class MenuVC: MainViewControllerS {

    // outlet for the main collectionView
    @IBOutlet weak var categoriesCV: UICollectionView!
    
    // get all categroies from server
    var getAll = MenuViewModel()
    
    // hold root json for categories
    var res:RootCategory?
    
    // current page categories
    var currentPage = [Category]()
    
    // hold all categories
    
    var allPages = [[Category]]()
    
    // prev - next moving needle
    var needle = 0
     
    
    let dispatchG = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // configure collectionView dataSource & delegate + register
   
       categoriesCV.delegate = self
       
       categoriesCV.dataSource = self
       
       categoriesCV.register(UINib(nibName: "CateCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    
        getAllData()
       
    }
   
    // get categories
    
    func getAllData() {
        
        if Utilities.noNetwork() {
            
            noInternet()
        }
        else {
            
            self.getAll.start(self, params: [:])
          
        }
        
    }
    
    // success part of getting data

    func sendData(_ res:RootCategory) {
        
        self.res = res
        
        allPages = self.res?.data.chunked(into: 20) ?? []
        
        currentPage = allPages.first ?? []
        
        self.categoriesCV.reloadData()
        
    }
    
     // fail part of getting data
    
    func fail() {
        
        let alert = UIAlertController(title: "Error Message", message: "Problem downloading data", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "ReTry", style: .default, handler: { (act) in
            self.getAllData()
        }))
        self.present(alert, animated: true, completion: nil)
         
    }
    
     // No internet connection
    
    func noInternet() {
        
        let alert = UIAlertController(title:nil , message: "No internet connection", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "ReTry", style: .default, handler: { (act) in
           self.getAllData()
        }))
        self.present(alert, animated: true, completion: nil)
         
    }
    
    // previous button click
    
    @IBAction func prevClicked(_ sender: Any) {
        
        if needle - 1 >= 0 {
            
            needle -= 1
            
            currentPage = allPages[needle]
            
            categoriesCV.reloadData()
            
        }
         
    }
    
    // next button click
    
    @IBAction func nextClicked(_ sender: Any) {
        
        if needle + 1 < allPages.count {
            
            needle += 1
            
            currentPage = allPages[needle]
            
            categoriesCV.reloadData()
            
        }

    }
}



// implement dataSource & delegate of the collection

extension MenuVC :  UICollectionViewDelegate  , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         
        return currentPage.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
        let wid = (self.view.frame.width  - 40 ) / 3
        
     //   print(wid)
        
        return CGSize(width:wid, height:100)
       
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CateCollectionCell
          
             let item = currentPage[indexPath.row]
        
             cell.nameLbl.text = item.name
        
             return cell
            
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = self.storyboard!.instantiateViewController(identifier: "ProductVC") as! ProductVC
        
        vc.delegate = self
        
        vc.selectedCate = currentPage[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated:true)
        
    } 

}

// implement proptocol for communication between MenuVC and ProductVC

extension MenuVC:PassingManager {
    
    func selected(_ product:ProductModel) {
         
        self.navigationController?.popToRootViewController(animated: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            let vc = self.storyboard!.instantiateViewController(identifier: "ProductDetailsVC") as! ProductDetailsVC
            
            vc.modalPresentationStyle = .overCurrentContext
            
            vc.product = product
            
            self.present(vc, animated: true, completion: nil)
            
        }
         
    }
    
}

// facilitate chunking the pages
 
extension List {
    
    func chunked(into size: Int) -> [[Element]] {
        
        return stride(from: 0, to: count, by: size).map {
            
            Array(self[$0 ..< Swift.min($0 + size, count)])
            
        }
        
    }
    
}
