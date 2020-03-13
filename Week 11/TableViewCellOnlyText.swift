//
//  TableViewCellOnlyText.swift
//  FirebaseHelloWorld
//
//  Created by admin on 13/03/2020.
//  Copyright © 2020 Markus. All rights reserved.
//

import UIKit

class TableViewCellOnlyText: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
