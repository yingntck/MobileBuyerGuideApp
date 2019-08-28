//
//  DetailViewController.swift
//  MobileBuyer
//
//  Created by Nanthicha Kritveeranant on 28/8/2562 BE.
//  Copyright © 2562 Nanthicha Kritveeranant. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
  var detail: String = ""
  var price: Double = 0.0
  var raiting: Double = 0.0
  
  
  @IBOutlet weak var raitingLabel: UILabel!
  @IBOutlet weak var detailLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    detailLabel.text = detail
    raitingLabel.text = "Raiting: \(raiting)"
    priceLabel.text = "Price: $\(price)"
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
