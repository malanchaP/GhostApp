//
//  ActiveticketTableViewCell.swift
//  GhostApp
//
//  Created by APPDEV on 26/12/21.
//

import UIKit

class ActiveticketTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var timeLbl: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var address: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var ticketLbl: UILabel!
    @IBOutlet var cellbtn: UIButton!
    @IBOutlet var chrgerimg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
