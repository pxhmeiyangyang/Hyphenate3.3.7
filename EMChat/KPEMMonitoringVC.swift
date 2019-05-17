//
//  KPEMMonitoringVC.swift
//  EMChat
//
//  Created by pxh on 2019/5/17.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

/// 环信聊天 监控界面
class KPEMMonitoringVC: UIViewController {

    /// 视屏界面
    lazy var videoView: UIView = {
        let view = UIView()
        self.view.addSubview(view)
        return view
    }()
    
    /// 控制界面
    lazy var controlView: UIView = {
        let view = UIView()
        self.view.addSubview(view)
        return view
    }()
    
    /// 控制界面背景
    lazy var controlBG: UIImageView = {
        let view = UIImageView()
        controlView.addSubview(view)
        view.image = UIImage.init(named: "video_bg")
        view.isUserInteractionEnabled = true
        return view
    }()
    
    /// 左侧按钮
    lazy var leftBTN: UIButton = {
        let view = UIButton()
        controlBG.addSubview(view)
        view.setBackgroundImage(UIImage.init(named: "video_anjian_L"), for: UIControlState.normal)
        view.setBackgroundImage(UIImage.init(named: "video_anjian_LS"), for: UIControlState.highlighted)
        return view
    }()
    
    /// 右侧控制按钮
    lazy var rightBTN: UIButton = {
        let view = UIButton()
        controlBG.addSubview(view)
        view.setBackgroundImage(UIImage.init(named: "video_anjian_R"), for: UIControlState.normal)
        view.setBackgroundImage(UIImage.init(named: "video_anjian_RS"), for: UIControlState.highlighted)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "安全监控"
        deploySubviews()
    }
    
    /// 配置子view
    private func deploySubviews(){
        videoView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(261)
        }
        
        controlView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(videoView.snp.bottom)
        }
        
        controlBG.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        leftBTN.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.width.equalTo(180)
            make.height.equalTo(241)
            make.right.equalTo(controlBG.snp.centerX)
        }
        
        rightBTN.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.width.equalTo(180)
            make.height.equalTo(241)
            make.left.equalTo(controlBG.snp.centerX)
        }
    }
    
}
