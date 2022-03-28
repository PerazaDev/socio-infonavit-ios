//
//  BenevitCollectionViewCell.swift
//  SocioInfonavitNextia
//
//  Created by Daniel Sanchez Peraza on 26/03/22.
//

import UIKit

class BenevitCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        logoImage.showAnimatedGradientSkeleton()
        descriptionLabel.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .systemGray6), animation: nil, transition: .crossDissolve(0.7))
    }
    
    func setupCell(benevit : BenevitModelMap){
        descriptionLabel.text = benevit.benevit.title
        DashboardController.shared.imageResponse(urlImg: benevit.benevit.ally.mini_logo_full_path) { imagen in
            DispatchQueue.main.async {
                self.logoImage.image = imagen
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
            
                
                self.logoImage.hideSkeleton()
                self.logoImage.stopSkeletonAnimation()
                self.descriptionLabel.hideSkeleton()
                self.descriptionLabel.stopSkeletonAnimation()
            }

        }
    }

}
