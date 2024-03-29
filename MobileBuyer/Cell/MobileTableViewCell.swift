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
  
  var mImageStar:UIImage!
  var isFavorited: Bool!
  var mobileVC:MobileItemViewController!
  var index: Int!
  
  @IBOutlet weak var ImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var detailLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var starBtn: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUpButton()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func setUpButton(){
    starBtn.tintColor = UIColor.blue
    starBtn.addTarget(self, action: #selector(handleMarkFavorite), for: .touchUpInside)
    isFavorited = false
  }
  
  func updateStar(isFav: Bool) {
    if isFav {
      mImageStar  = UIImage(named: "star-tap.png")!
      starBtn.setImage(mImageStar, for: .normal)
      isFavorited = true
    } else {
      isFavorited = false
      mImageStar  = UIImage(named: "star.png")!
      starBtn.setImage(mImageStar, for: .normal)
    }
  }
  
  @objc
  func handleMarkFavorite() {
    isFavorited = !isFavorited
    mobileVC.addCellToFavourite(cell: self, isFav: isFavorited)
  }
}
