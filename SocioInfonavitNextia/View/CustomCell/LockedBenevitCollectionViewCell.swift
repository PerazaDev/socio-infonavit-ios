//
//  LockedBenevitCollectionViewCell.swift
//  SocioInfonavitNextia
//
//  Created by Daniel Sanchez Peraza on 26/03/22.
//

import UIKit
import SkeletonView

class LockedBenevitCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var objectImage: UIImageView!
    @IBOutlet weak var offerButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        offerButton.layer.cornerRadius = 10
        objectImage.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .systemGray6), animation: nil, transition: .crossDissolve(0.5))
        offerButton.showAnimatedGradientSkeleton()
    }
    
    func setupCell (benevit: BenevitModelMap){
        DashboardController.shared.imageResponse(urlImg: benevit.benevit.vector_full_path) { imagen in
            DispatchQueue.main.asyncAfter(deadline: .now()+1.7) {
                self.objectImage.image = imagen
                self.offerButton.hideSkeleton()
                self.offerButton.stopSkeletonAnimation()
                self.objectImage.hideSkeleton()
                self.objectImage.stopSkeletonAnimation()
            }

        }
       
    }
    

}
