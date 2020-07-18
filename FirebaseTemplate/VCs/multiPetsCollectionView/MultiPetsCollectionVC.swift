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
    let cellScale: CGFloat = 0.6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        retrieveAllPets()
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
//    func setCellImage() {
//        SDWebImageDownloader().downloadImage(with: petInfo.imageUrl, options: .highPriority, progress: {  (receivedSize, expectedSize, url) in
//                   // image is being downloading and you can monitor progress here
//               }) { (downloadedImage, data, error, success) in
//                   self.imageView.image = downloadedImage
//               }
//    }
}
