//
//  ChargerListTableViewCell.swift
//  GhostApp
//
//  Created by APPDEV on 26/12/21.
//

import UIKit

class ChargerListTableViewCell: UITableViewCell {
    @IBOutlet var localimageView: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var level: UILabel!
    @IBOutlet var outletType: UILabel!
    @IBOutlet var parkingLimit: UILabel!
    @IBOutlet var scanBtn: UIButton!
    @IBOutlet var cellbtn: UIButton!
    @IBOutlet var directionbtn: UIButton!
    @IBOutlet var maskvw: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        localimageView.layer.cornerRadius = 20
        scanBtn.layer.cornerRadius = 10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
