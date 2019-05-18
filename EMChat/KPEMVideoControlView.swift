//
//  KPEMVideoControlView.swift
//  EMChat
//
//  Created by pxh on 2019/5/18.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

/// 呼叫界面回调
protocol KPEMVideoControlViewDelegate {
    func action(type: KPEMVideoControlView.ControlEvent?)
}

/// 环信 视频通话控制界面
class KPEMVideoControlView: UIView {

    /// 控制类型
    ///
    /// - video: 视频
    /// - monitoring: 监控
    enum ControlType {
        case video
        case monitoring
    }

    /// 控制事件说明
    ///
    /// - chageVoice: 切换到语音
    /// - rollback: 反转摄像头
    /// - mute: 静音
    /// - hangup: 挂断
    /// - picture: 拍照
    /// - record: 录像
    enum ControlEvent: Int {
        case chageVoice = 3000
        case rollback
        case mute
        case hangup
        case picture
        case record
    }
    
    private let viewTag: Int = 3000
    
    var delegate: KPEMVideoControlViewDelegate?
    
    /// 切换语音
    lazy var voiceBTN: CallingBTN = {
        let view = CallingBTN.init(title: "切换到语音通话",height: 60)
        self.addSubview(view)
        view.setImage(UIImage.init(named: "video_voice"), for: UIControlState.normal)
        view.setImage(UIImage.init(named: "video_voice"), for: UIControlState.highlighted)
        view.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
        view.tag = self.viewTag
        return view
    }()
    
    /// 反转摄像头
    lazy var rollbackBTN: UIButton = {
        let view = UIButton()
        view.setImage(UIImage.init(named: "video_icon1"), for: UIControlState.normal)
        view.setImage(UIImage.init(named: "video_icon1"), for: UIControlState.highlighted)
        self.addSubview(view)
        view.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
        view.tag = self.viewTag + 1
        return view
    }()
    
    /// 静音按钮
    lazy var muteBTN: UIButton = {
        let view = UIButton()
        view.setImage(UIImage.init(named: "video_icon5_1"), for: UIControlState.normal)
        view.setImage(UIImage.init(named: "video_icon5"), for: UIControlState.selected)
        self.addSubview(view)
        view.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
        view.tag = self.viewTag + 2
        return view
    }()
    
    
    
    /// 挂断按钮
    lazy var hangupBTN: UIButton = {
        let view = UIButton()
        view.setImage(UIImage.init(named: "video_chat1"), for: UIControlState.normal)
        view.setImage(UIImage.init(named: "video_chat1"), for: UIControlState.highlighted)
        self.addSubview(view)
        view.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
        view.tag = self.viewTag + 3
        return view
    }()
    
    
    /// 拍照按钮
    lazy var pictureBTN: UIButton = {
        let view = UIButton()
        view.setImage(UIImage.init(named: "video_icon3"), for: UIControlState.normal)
        view.setImage(UIImage.init(named: "video_icon3"), for: UIControlState.highlighted)
        self.addSubview(view)
        view.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
        view.tag = self.viewTag + 4
        return view
    }()
    
    /// 录制按钮
    lazy var recordBTN: UIButton = {
        let view = UIButton()
        view.setImage(UIImage.init(named: "video_icon4"), for: UIControlState.normal)
        view.setImage(UIImage.init(named: "video_icon6_1"), for: UIControlState.selected)
        self.addSubview(view)
        view.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
        view.tag = self.viewTag + 5
        return view
    }()
    
    convenience init(type: ControlType) {
        self.init()
        self.backgroundColor = UIColor.clear
        self.deploySubviews()
        self.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI_2))
    }

    /// 配置布局子视图
    private func deploySubviews(){
        /// 切换语音
        voiceBTN.snp.makeConstraints { (make) in
            make.top.equalTo(34)
            make.left.equalTo(20)
            make.width.equalTo(100)
            make.height.equalTo(60)
        }
        
        
        /// 反转摄像头
        rollbackBTN.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.bottom.equalTo(-20)
            make.centerX.equalToSuperview().offset(interval(tag: rollbackBTN.tag))
        }
        
        /// 静音按钮
        muteBTN.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.bottom.equalTo(-20)
            make.centerX.equalToSuperview().offset(interval(tag: muteBTN.tag))
        }
        
        
        /// 挂断按钮
        hangupBTN.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.bottom.equalTo(-20)
            make.centerX.equalToSuperview()
        }
        
        
        /// 拍照按钮
        pictureBTN.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.bottom.equalTo(-20)
            make.centerX.equalToSuperview().offset(interval(tag: pictureBTN.tag))
        }
        
        /// 录制按钮
        recordBTN.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.bottom.equalTo(-20)
            make.centerX.equalToSuperview().offset(interval(tag: recordBTN.tag))
        }
        
    }
    
    
    /// 计算图标间隔
    ///
    /// - Returns: 间隔数据
    private func interval(tag: Int)->CGFloat{
        return CGFloat(tag - 3003) * 140.0
    }
    
    @objc func buttonAction(sender: UIButton){
        if let delegate = delegate{
            delegate.action(type: KPEMVideoControlView.ControlEvent.init(rawValue: sender.tag))
        }
    }
}
