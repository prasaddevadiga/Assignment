//
//  CarDetailTableViewCell.swift
//  CarSearch
//
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit
import SDWebImage

class CarDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var vehicleModelLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!

    func updateWithCarDetail(carDetail: CarDetail) {
        
        userNameLabel.text = carDetail.user?.firstName
        placeLabel.text = "\(carDetail.user?.street ?? "")  \(carDetail.user?.city ?? "")"
        vehicleModelLabel.text = "\(carDetail.car?.make ?? ""), \(carDetail.car?.model ?? "")"
        guard let imageView =  profilePic, let url = URL(string: carDetail.user?.imageURL ?? "") else {return}
        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profilePic.image = nil
    }
}
