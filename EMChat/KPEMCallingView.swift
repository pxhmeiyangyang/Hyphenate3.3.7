//
//  KPEMCallingView.swift
//  EMChat
//
//  Created by pxh on 2019/5/17.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

/// 视频呼叫界面
class KPEMCallingView: UIView {

    /// 呼叫类型
    ///
    /// - caller: 主叫
    /// - called: 被叫
    enum callType {
        case caller
        case called
    }
    
    
    /// 背景图片
    private let BGIM = UIImageView.init(image: UIImage.init(named: "video_bgD"))
    
    /// 头像
    lazy var headerIM: UIImageView = {
        let view = UIImageView()
        self.addSubview(view)
        view.image = UIImage.init(named: "video_face1")
        return view
    }()
    
    
    /// 标题
    lazy var titleLB: UILabel = {
        let view = UILabel()
        self.addSubview(view)
        view.textColor = UIColor.white
        view.font = UIFont.systemFont(ofSize: 22)
        return view
    }()
    
    /// 呼叫状态
    lazy var callingLB: UILabel = {
        let view = UILabel()
        self.addSubview(view)
        view.textColor = UIColor.white
        view.font = UIFont.systemFont(ofSize: 16)
        return view
    }()
    
    /// 取消按钮
    lazy var cancelBTN: CallingBTN = {
        let view = CallingBTN.init(title: "取消")
        self.addSubview(view)
        view.setImage(UIImage.init(named: "video_chat1"), for: UIControlState.normal)
        view.setImage(UIImage.init(named: "video_chat1"), for: UIControlState.highlighted)
        return view
    }()
    
    /// 取消按钮
    lazy var answerBTN: CallingBTN = {
        let view = CallingBTN.init(title: "接听")
        self.addSubview(view)
        view.setImage(UIImage.init(named: "video_chat2"), for: UIControlState.normal)
        view.setImage(UIImage.init(named: "video_chat2"), for: UIControlState.highlighted)
        return view
    }()
    
    /// 切换语音
    lazy var voiceBTN: CallingBTN = {
        let view = CallingBTN.init(title: "切换到语音通话")
        self.addSubview(view)
        view.setImage(UIImage.init(named: "video_voice"), for: UIControlState.normal)
        view.setImage(UIImage.init(named: "video_voice"), for: UIControlState.highlighted)
        return view
    }()
    
    /// 初始化
    ///
    /// - Parameters:
    ///   - type: 呼叫类型
    ///   - fame: 大小
    convenience init(type: callType,fame: CGRect ) {
        self.init()
        deploySubviews()
        self.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI_2))
    }
    
    /// 更新UI界面
    ///
    /// - Parameter type: 视图类型
    private func updateUI(type: callType){
        switch type {
        case .caller:
            answerBTN.isHidden = true
            cancelBTN.snp.updateConstraints { (make) in
                make.centerX.equalToSuperview()
            }
        case .called:
            cancelBTN.snp.updateConstraints { (make) in
                make.centerX.equalToSuperview().offset(-90)
            }
            answerBTN.isHidden = false
            answerBTN.snp.updateConstraints { (make) in
                make.centerX.equalToSuperview().offset(90)
            }
        default:
            break
        }
    }
    
    /// 布局子view
    private func deploySubviews(){
        self.addSubview(BGIM)
        BGIM.sendSubview(toBack: self)
        BGIM.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        headerIM.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(30)
            make.width.height.equalTo(70)
        }
        
        /// 标题
        titleLB.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.equalTo(100)
        }
        
        /// 呼叫状态
        callingLB.snp.makeConstraints { (make) in
            make.top.equalTo(72)
            make.left.equalTo(100)
        }
        
        /// 取消按钮
        cancelBTN.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(90)
            make.centerX.equalToSuperview()
        }
        
        /// 取消按钮
        answerBTN.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(90)
            make.centerX.equalToSuperview()
        }
        
        /// 切换语音
        voiceBTN.snp.makeConstraints { (make) in
            make.top.equalTo(34)
            make.left.equalTo(-20)
            make.width.equalTo(100)
            make.height.equalTo(60)
        }
        
    }
}


/// 呼叫button
class CallingBTN: UIButton{
    
    /// 标签
    lazy var titleLB: UILabel = {
        let view = UILabel()
        self.addSubview(view)
        view.textColor = UIColor.white
        view.font = UIFont.systemFont(ofSize: 14)
        view.textAlignment = NSTextAlignment.center
        return view
    }()
    
    convenience init(title: String) {
        self.init()
        deploySubviews()
        self.titleLB.text = title
        self.titleLB.sizeToFit()
        self.imageEdgeInsets = UIEdgeInsets.init(top: 30, left: 0, bottom: 0, right: 0)
    }
    
    /// 配置子view
    private func deploySubviews(){
        titleLB.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
