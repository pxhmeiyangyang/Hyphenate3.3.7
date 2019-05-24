//
//  KPLinkManCell.swift
//  EMChat
//
//  Created by pxh on 2019/5/20.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

/// 联系人列表cell
class KPLinkManCell: UITableViewCell {

    /// 头像图标
    private lazy var headerIM: HeaderIM = {
        let view = HeaderIM.init(imageName: "chat_speek_face1")
        addSubview(view)
        return view
    }()
    
    
    /// 名称标签
    private lazy var nameLB: StatusLabel = {
        let view = StatusLabel.init(fontSize: 16, onLineTextColor: UIColor.UT20Color(), textColor: UIColor.UTB0Color(), onLineBGColor: UIColor.clear, BGColor: UIColor.clear)
        addSubview(view)
        view.text = "明明的聪聪机器人"
        return view
    }()
    
    /// 状态按钮
    private lazy var statusLB: StatusLabel = {
        let view = StatusLabel.init(fontSize: 11, onLineTextColor: UIColor.white, textColor: UIColor.white, onLineBGColor: UIColor.hexStringToColor(hexString: "FF9400"), BGColor: UIColor.UTB0Color())
        addSubview(view)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 7
        view.onLineText = "在线"
        view.offLineText = "离线"
        view.textAlignment = NSTextAlignment.center
        return view
    }()
    
    /// 内容标签
    lazy var contentLB: UILabel = {
        let view = UILabel()
        addSubview(view)
        view.textColor = UIColor.UT79Color()
        view.font = UIFont.systemFont(ofSize: 14)
        view.text = "Glenn：学习更多诗词"
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        deploySubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    /// 配置所有子view
    private func deploySubviews(){
        /// 头像图标
        headerIM.snp.makeConstraints { (make) in
            make.width.height.equalTo(45)
            make.centerY.equalToSuperview()
            make.left.equalTo(20)
        }
        
        
        /// 名称标签
        nameLB.snp.makeConstraints { (make) in
            make.top.equalTo(18)
            make.left.equalTo(headerIM.snp.right).offset(10)
        }
        
        /// 状态按钮
        statusLB.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLB)
            make.left.equalTo(nameLB.snp.right).offset(10)
            make.width.equalTo(32)
        }
        
        /// 内容标签
        contentLB.snp.makeConstraints { (make) in
            make.bottom.equalTo(-17)
            make.left.equalTo(headerIM.snp.right).offset(10)
        }
        
        let line = UIView()
        line.backgroundColor = UIColor.hexStringToColor(hexString: "F5F5F5")
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(0)
            make.height.equalTo(1)
            make.left.equalTo(20)
        }
    }
 
    
    class func cellHeight()->CGFloat{
        return 80
    }
    
}



/// 状态按钮
private class StatusLabel: UILabel{
 
    var _onLine: Bool = true //默认在线
    var onLine: Bool{
        set{
            _onLine = newValue
            if newValue {
                self.textColor = onLineTextColor
                self.backgroundColor = onLineBGColor
                guard let temp = onLineText, temp.count > 0 else { return }
                self.text = temp
            }else{
                self.textColor = KPtextColor
                self.backgroundColor = BGColor
                guard let temp = offLineText, temp.count > 0 else { return }
                self.text = temp
            }
        }
        get{
            return _onLine
        }
    }
    
    private var onLineTextColor: UIColor?
    private var KPtextColor: UIColor?
    private var onLineBGColor: UIColor?
    private var BGColor: UIColor?
    
    var onLineText: String?
    var offLineText: String?
    
    convenience init(fontSize: CGFloat,onLineTextColor: UIColor,textColor: UIColor,onLineBGColor: UIColor,BGColor: UIColor) {
        self.init()
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textColor = textColor
        self.onLineTextColor = onLineTextColor
        self.KPtextColor = textColor
        self.onLineBGColor = onLineBGColor
        self.BGColor = BGColor
        self.onLine = true
        self.text = "在线"
    }
}


/// 联系人定制头像
private class HeaderIM: UIImageView {
    
    var _onLine: Bool = true //默认在线
    var onLine: Bool{
        set{
            _onLine = newValue
            badge.isHidden = !newValue
            masking.isHidden = newValue
        }
        get{
            return _onLine
        }
    }
    
    /// 徽章
    lazy var badge: UIView = {
        let view = UIView()
        addSubview(view)
        view.backgroundColor = UIColor.hexStringToColor(hexString: "FF3638")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4.5
        return view
    }()
    
    /// 蒙版图片
    lazy var masking: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 0.5)
        return view
    }()
    
    
    convenience init(imageName: String) {
        self.init()
        self.image = UIImage.init(named: imageName)
        deploySubviews()
        self.onLine = true
    }
    
    private func deploySubviews(){
        badge.snp.makeConstraints { (make) in
            make.width.height.equalTo(9)
            make.top.equalTo(0)
            make.right.equalTo(-4.5)
        }
        
        addSubview(masking)
        masking.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

