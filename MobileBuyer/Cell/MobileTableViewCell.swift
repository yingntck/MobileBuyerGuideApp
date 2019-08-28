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
  var mWhenTap:Bool!
  var mobileVC:MobileItemViewController!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    setUpButtun()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  func setUpButtun(){
    starBtn.tintColor = UIColor.blue
    starBtn.addTarget(self, action: #selector(handleMarkFavorite), for: .touchUpInside)
    self.mWhenTap = true
  }
  
  @objc
  func handleMarkFavorite() {
    if mWhenTap {
      mImageStar  = UIImage(named: "star-tap.png")!
      starBtn.setImage(mImageStar, for: .normal)
      self.mWhenTap = false
    }else{
      mImageStar  = UIImage(named: "star.png")!
      starBtn.setImage(mImageStar, for: .normal)
      self.mWhenTap = true
    }
    //        mobileVC.addCellToFavourite(cell: self)
  }
  
}
