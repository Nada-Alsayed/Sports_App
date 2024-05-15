//
//  SportsVC.swift
//  SportyX
//
//  Created by MAC on 23/05/2023.
//

import UIKit

class SportsVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    let sportsName:[String]=["Football","Basketball","Cricket","Tennis"]
    let sportsImage:[String]=["football","basketball","crickit","tennis"]
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCell", for: indexPath) as!SportsCell
         cell.sportName.text = sportsName[indexPath.row]
         cell.sportImg.image = UIImage(named: sportsImage[indexPath.row])
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let LeagueScreen = self.storyboard?.instantiateViewController(withIdentifier: "myTable") as! LeaguesVC
        if(indexPath.row == 0){
//            UserDefaults.standard.set(Names.FOOTBALL, forKey: "destination")
//            UserDefaults.standard.synchronize()
//
            LeagueScreen.destination = Names.FOOTBALL
        }else if(indexPath.row == 1){
//            UserDefaults.standard.set(Names.BASKETBALL, forKey: "destination")
//            UserDefaults.standard.synchronize()
//
            LeagueScreen.destination = Names.BASKETBALL
        }else if(indexPath.row == 2){
//            UserDefaults.standard.set(Names.CRICKET, forKey: "destination")
//            UserDefaults.standard.synchronize()
//
            LeagueScreen.destination = Names.CRICKET
        }else{
//            UserDefaults.standard.set(Names.TENNIS, forKey: "destination")
//            UserDefaults.standard.synchronize()
//
            LeagueScreen.destination = Names.TENNIS
        }
        LeagueScreen.modalPresentationStyle = .fullScreen

        present(LeagueScreen, animated: true, completion: nil)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 10)/2
        return CGSize(width: size, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.2
    }

     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsName.count
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hI")
        myCollectionView.register(UINib(nibName: "SportsCell", bundle: nil), forCellWithReuseIdentifier: "SportsCell")
        myCollectionView.collectionViewLayout = UICollectionViewFlowLayout()

        // Do any additional setup after loading the view.
    }
    

}
