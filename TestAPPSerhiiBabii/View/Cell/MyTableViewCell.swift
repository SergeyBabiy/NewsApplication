//
//  MyTableViewCell.swift
//  TestAPPSerhiiBabii
//
//  Created by Сергей Бабий on 15.07.2021.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var labelCell: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        imageCell.image = nil
    }
}
