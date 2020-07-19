//
//  MultiPetsCollectionVC.swift
//  FirebaseTemplate
//
//  Created by Huda on 7/16/20.
//  Copyright © 2020 OMAR. All rights reserved.
//
//UICollectionViewDelegate, UICollectionViewDataSource
import UIKit
import SDWebImage

private let reuseIdentifier = "Cell"
class MultiPetsCollectionVC: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        retrieveAllPets()
    }
    
    @IBAction func signOutBtn(_ sender: Any) {
        Networking.signOut()
        performSegue(withIdentifier: "signedOut", sender: self)
    }
    @IBAction func plusBtn(_ sender: Any) {
        performSegue(withIdentifier: "addPet", sender: self)
    }
    
    func retrieveAllPets(){
        guard let uid = Networking.getUserId() else{
            print("Coulndn't retreive pets")
            return
        }
        Networking.getListOf(COLLECTION_NAME: "users/\(uid)/pets") { (pets: [Pet]) in
            myPets = pets
            self.collectionView.reloadData()
        }
    }
}

extension MultiPetsCollectionVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return myPets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCollectionViewCell
        
        // Configure the cell
        let pet = myPets[indexPath.row]
        cell.petNameLabel.text = pet.petName
        cell.petImgView.layer.cornerRadius = cell.petImgView.frame.size.width/2
        cell.petImgView.sd_setImage(with:  URL(string: pet.imageUrl ?? "https://img.huffingtonpost.com/asset/5b7fdeab1900001d035028dc.jpeg"), completed: nil)
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let totalCellWidth = 80 * collectionView.numberOfItems(inSection: 0)
        let totalSpacingWidth = 10 * (collectionView.numberOfItems(inSection: 0) - 1)
        
        let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pet = myPets[indexPath.row]
        performSegue(withIdentifier: "details", sender: indexPath.row)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details"{
            let vc = segue.destination as! ProfileVC
            let index = sender as! Int
            vc.selectedPet = myPets[index]
        }
    }
//
//    func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
//        let totalWidth = cellWidth * numberOfItems
//        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
//        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
//        let rightInset = leftInset
//        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: rightInset)
//    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//
//        let totalCellWidth = CellWidth * CellCount
//        let totalSpacingWidth = CellSpacing * (CellCount - 1)
//
//        let leftInset = (collectionViewWidth - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
//        let rightInset = leftInset
//
//        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
//    }
}
