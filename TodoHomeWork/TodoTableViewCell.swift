//
//  TodoTableViewCell.swift
//  TodoHomeWork
//
//  Created by 長島啓太朗 on 2023/09/04.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel :UILabel!
    @IBOutlet var bodyLabel :UILabel!
    @IBOutlet var dateLabel :UILabel!
    @IBOutlet var markImageView :UIImageView!
  
    // 端末設定によらず西暦（グレゴリオ暦）で処理するようにする
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCell(title:String,body:String,date:Date,isMarked:Bool){
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.locale = Locale(identifier: "ja_JP")
        titleLabel.text = title
        bodyLabel.text = body
        dateLabel.text = formatter.string(from: date)
        if isMarked{
            markImageView.image = UIImage(systemName: "star.fill")

        }else{
            markImageView.image = UIImage(systemName: "star")
        }
    }
}
