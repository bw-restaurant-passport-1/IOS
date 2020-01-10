//
//  RestaurantTableViewCell.swift
//  RestaurantPassport
//
//  Created by Christy Hicks on 12/17/19.
//  Copyright © 2019 Knight Night. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    var restaurant: Restaurant? {
        didSet {
            updateViews()
                
            
                
            }
        
    }
    
    private func updateViews() {
        
    
        
        
        
    }
    
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var star1Button: UIButton!
    @IBOutlet weak var star2Button: UIButton!
    @IBOutlet weak var star3Button: UIButton!
    @IBOutlet weak var star4Button: UIButton!
    @IBOutlet weak var star5Button: UIButton!
    @IBOutlet weak var stampButton: UIButton!
    
    // MARK: - Properties
    
    
    
    // MARK: - Methods
    // View
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      // Configure the view for the selected state
    }
    
    // Actions
    @IBAction func star1Selected(_ sender: UIButton) {
    }
    @IBAction func star2Selected(_ sender: UIButton) {
    }
    @IBAction func star3Selected(_ sender: UIButton) {
    }
    @IBAction func star4Selected(_ sender: UIButton) {
    }
    @IBAction func star5Selected(_ sender: UIButton) {
    }
    @IBAction func stampSelected(_ sender: UIButton) {
    
    }
}

