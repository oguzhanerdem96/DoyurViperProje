//
//  BasketTableViewCell.swift
//  DoyurViper
//
//  Created by Oğuzhan Erdem on 19.09.2022.
//

import UIKit
import Kingfisher

protocol TableViewCellDelegate : AnyObject {
    func didTapMinesBtnFromUser(_ cell: BasketTableViewCell)
    func didTapPlusBtnFromUser(_ cell: BasketTableViewCell)
}


class BasketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var UrunImage: UIImageView!
    @IBOutlet weak var UrunAdi: UILabel!
    @IBOutlet weak var UrunFiyat: UILabel!
    @IBOutlet weak var SilBtn: UIButton!
    @IBOutlet weak var CıkarBtn: UIButton!

    @IBOutlet weak var SayiBtn: UILabel!
    @IBOutlet weak var ArtıBtn: UIButton!

    weak var delegate : TableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func configureButtons() {
        CıkarBtn.addTarget(self, action: #selector(didTapMinesBtn), for: .touchUpInside)
        ArtıBtn.addTarget(self, action: #selector(didTapPlusBtn), for: .touchUpInside)
    }
    
    @objc func didTapMinesBtn() {
        delegate?.didTapMinesBtnFromUser(self)
    }
    
    @objc func didTapPlusBtn(){
        delegate?.didTapPlusBtnFromUser(self)
    }
}
