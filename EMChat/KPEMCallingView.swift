//
//  KPEMCallingView.swift
//  EMChat
//
//  Created by pxh on 2019/5/17.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

/// 呼叫界面回调
protocol KPEMCallingViewDelegate {
    func action(sender: UIButton)
}


/// 视频呼叫界面
class KPEMCallingView: UIView {

    /// 协议
    var delegate: KPEMCallingViewDelegate?
    
    /// 视图tag
    private let viewTag = 2000
    
    /// 呼叫类型
    ///
    /// - caller: 主叫
    /// - called: 被叫
    enum callType {
        case caller
        case called
    }
    
    /// 是否是只进行语音通话
    var _onlyVoice: Bool = false
    var onlyVoice: Bool{
        set{
            _onlyVoice = newValue
            guard newValue else { return }
            for tag in self.viewTag...self.viewTag + 2{
                guard let view = self.viewWithTag(tag) else { return }
                view.isHidden = true
            }
            deployOnlyVoiceSubviews()
        }
        get{
            return _onlyVoice
        }
    }
    
    /// 背景图片
    private let BGIM = UIImageView.init(image: UIImage.init(named: "video_bgD"))
    
    /// 头像
    lazy var headerIM: UIImageView = {
        let view = UIImageView()
        BGIM.addSubview(view)
        view.image = UIImage.init(named: "video_face1")
        return view
    }()
    
    
    /// 标题
    lazy var titleLB: UILabel = {
        let view = UILabel()
        BGIM.addSubview(view)
        view.textColor = UIColor.white
        view.font = UIFont.systemFont(ofSize: 22)
        view.text = "拥有花朵的懵喵"
        return view
    }()
    
    /// 呼叫状态
    lazy var callingLB: UILabel = {
        let view = UILabel()
        BGIM.addSubview(view)
        view.textColor = UIColor.white
        view.font = UIFont.systemFont(ofSize: 16)
        view.text = "正在呼叫......"
        return view
    }()
    
    /// 取消按钮
    lazy var cancelBTN: CallingBTN = {
        let view = CallingBTN.init(title: "取消",height: 90)
        BGIM.addSubview(view)
        view.setImage(UIImage.init(named: "video_chat1"), for: UIControlState.normal)
        view.setImage(UIImage.init(named: "video_chat1"), for: UIControlState.highlighted)
        view.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
        view.tag = self.viewTag
        return view
    }()
    
    /// 取消按钮
    lazy var answerBTN: CallingBTN = {
        let view = CallingBTN.init(title: "接听",height: 90)
        BGIM.addSubview(view)
        view.setImage(UIImage.init(named: "video_chat2"), for: UIControlState.normal)
        view.setImage(UIImage.init(named: "video_chat2"), for: UIControlState.highlighted)
        view.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
        view.tag = self.viewTag + 1
        return view
    }()
    
    /// 切换语音
    lazy var voiceBTN: CallingBTN = {
        let view = CallingBTN.init(title: "切换到语音通话",height: 60)
        BGIM.addSubview(view)
        view.setImage(UIImage.init(named: "video_voice"), for: UIControlState.normal)
        view.setImage(UIImage.init(named: "video_voice"), for: UIControlState.highlighted)
        view.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
        view.tag = self.viewTag + 2
        return view
    }()
    
    
    /// 静音按钮
    lazy var muteBTN: UIButton = {
        let view = UIButton()
        view.setImage(UIImage.init(named: "video_icon5"), for: UIControlState.normal)
        view.setImage(UIImage.init(named: "video_icon5_1"), for: UIControlState.selected)
        self.addSubview(view)
        view.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
        view.tag = self.viewTag + 3
        return view
    }()
    
    
    
    /// 挂断按钮
    lazy var hangupBTN: UIButton = {
        let view = UIButton()
        view.setImage(UIImage.init(named: "video_chat1"), for: UIControlState.normal)
        view.setImage(UIImage.init(named: "video_chat1"), for: UIControlState.highlighted)
        self.addSubview(view)
        view.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
        view.tag = self.viewTag + 4
        return view
    }()
    
    /// 初始化
    ///
    /// - Parameters:
    ///   - type: 呼叫类型
    ///   - fame: 大小
    convenience init(type: callType) {
        self.init()
        deploySubviews()
        self.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI_2))
        self.updateUI(type: type)
    }
    
    /// 更新UI界面
    ///
    /// - Parameter type: 视图类型
    private func updateUI(type: callType){
        switch type {
        case .caller:
            answerBTN.callHidden = true
            cancelBTN.snp.updateConstraints { (make) in
                make.centerX.equalToSuperview()
            }
        case .called:
            cancelBTN.snp.updateConstraints { (make) in
                make.centerX.equalToSuperview().offset(-90)
            }
            answerBTN.callHidden = false
            answerBTN.snp.updateConstraints { (make) in
                make.centerX.equalToSuperview().offset(90)
            }
        }
    }
    
    /// 配置只有语音通话的界面
    private func deployOnlyVoiceSubviews(){
        /// 静音按钮
        muteBTN.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.bottom.equalTo(-20)
            make.centerX.equalToSuperview().offset(-90)
        }
        
        
        /// 挂断按钮
        hangupBTN.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.bottom.equalTo(-20)
            make.centerX.equalToSuperview().offset(90)
        }
    }
    
    /// 布局子view
    private func deploySubviews(){
        self.addSubview(BGIM)
        BGIM.isUserInteractionEnabled = true
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
            make.bottom.equalTo(-27)
        }
        
        /// 取消按钮
        answerBTN.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(90)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-27)
        }
        
        /// 切换语音
        voiceBTN.snp.makeConstraints { (make) in
            make.top.equalTo(24)
            make.right.equalTo(-20)
            make.width.equalTo(100)
            make.height.equalTo(60)
        }
        
    }
    
    
    @objc func buttonAction(sender: UIButton){
        if let delegate = delegate{
            delegate.action(sender: sender)
        }
    }
}


/// 呼叫button
class CallingBTN: UIButton{
    
    var _callHidden: Bool = false
    var callHidden: Bool{
        set{
            _callHidden = newValue
            titleLB.isHidden = newValue
            self.isHidden = newValue
        }
        get{
            return _callHidden
        }
    }
    
    /// 标签
    lazy var titleLB: UILabel = {
        let view = UILabel()
        self.addSubview(view)
        view.textColor = UIColor.white
        view.font = UIFont.systemFont(ofSize: 14)
        view.textAlignment = NSTextAlignment.center
        return view
    }()
    
    convenience init(title: String,height: CGFloat) {
        self.init()
        deploySubviews()
        self.titleLB.text = title
        self.titleLB.sizeToFit()
    }
    
    
    
    /// 配置子view
    private func deploySubviews(){
        titleLB.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(10)
        }
    }
}
