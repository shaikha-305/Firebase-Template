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
        ownerName()
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
    func ownerName(){
        guard let uid = Networking.getUserId() else{
            print("user doesnt exist")
            return
        }
        Networking.getSingleDocument("users/\(uid)") { (user: User) in
            var userr = user.ownerName!
            print(userr)
        }
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
        //"https://img.huffingtonpost.com/asset/5b7fdeab1900001d035028dc.jpeg"
        //"https://i.pinimg.com/originals/02/2e/af/022eafe2c5fcb01d20e709e112fa6d7a.png"
        // first cat gif "https://cdn.discordapp.com/attachments/750333042610143303/767262786303557642/3.gif"
        //the loading dog gif "https://cdn.discordapp.com/attachments/750333042610143303/767262410725654568/ezgif.com-video-to-gif__2_.gif"
        // Configure the cell
        let pet = myPets[indexPath.row]
        cell.petNameLabel.text = pet.petName
        cell.petImgView.layer.cornerRadius = cell.petImgView.frame.size.width/2
        cell.petImgView.sd_setImage(with:  URL(string: pet.imageUrl ?? "https://i.pinimg.com/originals/02/2e/af/022eafe2c5fcb01d20e709e112fa6d7a.png"), completed: nil)
        return cell
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
}
