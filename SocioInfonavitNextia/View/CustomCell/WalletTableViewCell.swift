//
//  WalletTableViewCell.swift
//  SocioInfonavitNextia
//
//  Created by Daniel Sanchez Peraza on 26/03/22.
//

import UIKit
import SkeletonView

class WalletTableViewCell: UITableViewCell {
    var benevits : BenevitResponseModel?
    var walletIde = 0
    var benevit : [BenevitModelMap] = []
    let token : String = UserDefaults.standard.string(forKey: "tokenLogin")!
    @IBOutlet weak var titleWalletLabel: UILabel!
    @IBOutlet weak var benevitsCollectionIView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupCollection (){
        
        
        DashboardController.shared.benevitsResponse(token: token) { benevits in
            DispatchQueue.main.async {
                self.benevitsCollectionIView.register(UINib(nibName: "\(BenevitCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "benevitCell")
                self.benevitsCollectionIView.register(UINib(nibName: "\(LockedBenevitCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "lockedBenevitCell")
                self.benevitsCollectionIView.dataSource = self
                self.benevitsCollectionIView.delegate = self
                
                self.benevits = benevits
                self.benevits?.unlocked.forEach({ benevit in
                    
                    if benevit.wallet.id == self.walletIde{
                        self.benevit.append(BenevitModelMap.init(status: true, benevit: benevit))
                        
                    }
                })
                self.benevits?.locked.forEach({ benevit in
                    if benevit.wallet.id == self.walletIde{
                        self.benevit.append(BenevitModelMap.init(status: false, benevit: benevit))
                    }
                })
                
            }
            
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.titleWalletLabel.hideSkeleton()
            self.titleWalletLabel.stopSkeletonAnimation()
            self.titleWalletLabel.isSkeletonable = false
            
        }
        
    }
    
    func setupCell (wallet :WalletResponseModel){
        
        walletIde = wallet.id
        self.titleWalletLabel.showAnimatedGradientSkeleton()
        
        self.benevitsCollectionIView.showAnimatedGradientSkeleton()
        
        self.titleWalletLabel.text = wallet.name
        
        self.setupCollection()
        
        
    }
    
}
extension WalletTableViewCell : SkeletonCollectionViewDataSource{
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "benevitCell"
    }
   
    
}
extension WalletTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (self.benevits?.unlocked.filter({ benevit in
            benevit.wallet.id == walletIde
        }))!.count+(self.benevits?.locked.filter({ benevit in
            benevit.wallet.id == walletIde
        }))!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if benevit.isEmpty == false{
            if benevit[indexPath.row].status {
                guard let cell = benevitsCollectionIView.dequeueReusableCell(withReuseIdentifier: "benevitCell", for: indexPath)as? BenevitCollectionViewCell else{
                    return UICollectionViewCell()
                }
                cell.layer.cornerRadius = 30
                cell.setupCell(benevit: (benevit[indexPath.row]))
                
                return cell
            }
            else {
                
                guard let cell = benevitsCollectionIView.dequeueReusableCell(withReuseIdentifier: "lockedBenevitCell", for: indexPath)as? LockedBenevitCollectionViewCell else{
                    return UICollectionViewCell()
                }
                cell.layer.cornerRadius = 30
                cell.setupCell(benevit: (benevit[indexPath.row]))
                return cell
            }
        }
        return UICollectionViewCell()
    }
}


