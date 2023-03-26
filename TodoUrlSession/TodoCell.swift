//
//  TodoCell.swift
//  TodoUrlSession
//
//  Created by 김라영 on 2023/03/21.
//

import Foundation
import UIKit

class TodoCell: UITableViewCell {
    @IBOutlet weak var todoId: UILabel!
    @IBOutlet weak var todoContent: UILabel!
    
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var selectedSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
