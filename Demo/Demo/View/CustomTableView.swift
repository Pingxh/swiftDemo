//
//  CustomTableView.swift
//  Demo
//
//  Created by Apple on 2020/5/23.
//  Copyright © 2020 Yioks. All rights reserved.
//

import UIKit

class CustomTableView: UITableView {

    var dataArray = NSMutableArray()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        delegate = self
        dataSource = self
        estimatedRowHeight = 60.0
        isScrollEnabled = false
        register(CustomCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension CustomTableView : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.titleLabel.text = dataArray[indexPath.row] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}


class CustomCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        xh_setupUI()
        xh_makeSubviewsContraint()
    }
    
    func xh_setupUI() {
        contentView.addSubview(titleLabel)
    }
    
    func xh_makeSubviewsContraint() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(15)
            make.centerY.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel : UILabel = {
        let label = UILabel.init(frame: .zero)
        
        return label
    }()
}
