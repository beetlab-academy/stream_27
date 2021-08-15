//
//  CustomCell.swift
//  Callbacks
//
//  Created by nikita on 15.08.2021.
//

import UIKit

struct CustomCellState {
    let title: String
    let subtitle: String
}

class CustomCell: UITableViewCell {
    var state: CustomCellState? {
        didSet {
            topLabel.text = state?.title
            bottomLabel.text = state?.subtitle
        }
    }
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
}
