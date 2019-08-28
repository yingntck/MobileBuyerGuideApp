//
//  MobileTableViewCell.swift
//  MobileBuyer
//
//  Created by Nanthicha Kritveeranant on 27/8/2562 BE.
//  Copyright © 2562 Nanthicha Kritveeranant. All rights reserved.
//

import UIKit
import Foundation

class MobileTableViewCell: UITableViewCell {
  
  @IBOutlet weak var ImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var detailLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var raitingLabel: UILabel!
  @IBOutlet weak var starBtn: UIButton!
  var mImageStar:UIImage!
  var isTapped:Bool!
  var mobileVC:MobileItemViewController!
  var index: Int!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUpButtun()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func setUpButtun(){
    starBtn.tintColor = UIColor.blue
    starBtn.addTarget(self, action: #selector(handleMarkFavorite), for: .touchUpInside)
    self.isTapped = true
  }
  
  @objc
  func handleMarkFavorite() {
    //    print("fav index \(index ?? 0) is tapped")
    print(mobileVC.dataInfo[index])
    if isTapped {
      mImageStar  = UIImage(named: "star-tap.png")!
      starBtn.setImage(mImageStar, for: .normal)
      self.isTapped = false
    } else {
      mImageStar  = UIImage(named: "star.png")!
      starBtn.setImage(mImageStar, for: .normal)
      self.isTapped = true
    }
    //        mobileVC.addCellToFavourite(cell: self)
  }
  
//    @IBAction func favTapped(_ sender: Any) {
//      print("Fav")
//    }
  
}
