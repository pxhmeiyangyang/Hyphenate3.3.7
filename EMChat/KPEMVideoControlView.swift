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
    func action(sender: UIButton,type: KPEMVideoControlView.ControlEvent?)
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
        case changeVoice = 3000
        case rollback
        case mute
        case hangup
        case picture
        case record
        case cancel
        case monitor2Video
    }
    
    var delegate: KPEMVideoControlViewDelegate?
    
    /// 返回按钮
    lazy var cancelBTN: UIButton = {
        let view = UIButton()
        addSubview(view)
        view.setImage(UIImage.init(named: "back_white"), for: UIControlState.normal)
        view.setImage(UIImage.init(named: "back_white"), for: UIControlState.normal)
        view.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
        view.tag = ControlEvent.cancel.rawValue
        return view
    }()
    
    /// 切换语音
    lazy var voiceBTN: CallingBTN = {
        let view = CallingBTN.init(title: "切换到语音通话",height: 60)
        self.addSubview(view)
        view.setImage(UIImage.init(named: "video_voice"), for: UIControlState.normal)
        view.setImage(UIImage.init(named: "video_voice"), for: UIControlState.highlighted)
        view.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
        view.tag = ControlEvent.changeVoice.rawValue
        return view
    }()
    
    /// 反转摄像头
    lazy var rollbackBTN: UIButton = {
        let view = UIButton()
        view.setImage(UIImage.init(named: "video_icon1"), for: UIControlState.normal)
        view.setImage(UIImage.init(named: "video_icon1"), for: UIControlState.highlighted)
        self.addSubview(view)
        view.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
        view.tag = ControlEvent.rollback.rawValue
        return view
    }()
    
    /// 静音按钮
    lazy var muteBTN: UIButton = {
        let view = UIButton()
        view.setImage(UIImage.init(named: "video_icon5"), for: UIControlState.normal)
        view.setImage(UIImage.init(named: "video_icon5_1"), for: UIControlState.selected)
        self.addSubview(view)
        view.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
        view.tag = ControlEvent.mute.rawValue
        return view
    }()
    
    
    
    /// 挂断按钮
    lazy var hangupBTN: UIButton = {
        let view = UIButton()
        view.setImage(UIImage.init(named: "video_chat1"), for: UIControlState.normal)
        view.setImage(UIImage.init(named: "video_chat1"), for: UIControlState.highlighted)
        self.addSubview(view)
        view.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
        view.tag = ControlEvent.hangup.rawValue
        return view
    }()
    
    
    /// 拍照按钮
    lazy var pictureBTN: UIButton = {
        let view = UIButton()
        view.setImage(UIImage.init(named: "video_icon3"), for: UIControlState.normal)
        view.setImage(UIImage.init(named: "video_icon3"), for: UIControlState.highlighted)
        self.addSubview(view)
        view.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
        view.tag = ControlEvent.picture.rawValue
        return view
    }()
    
    /// 录制按钮
    lazy var recordBTN: UIButton = {
        let view = UIButton()
        view.setImage(UIImage.init(named: "video_icon4"), for: UIControlState.normal)
        view.setImage(UIImage.init(named: "video_icon6_1"), for: UIControlState.selected)
        self.addSubview(view)
        view.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
        view.tag = ControlEvent.record.rawValue
        return view
    }()
    
    /// 监控切视频通话
    lazy var monitor2VideoBTN: UIButton = {
        let view = UIButton()
        view.setImage(UIImage.init(named: "video_iconSXT"), for: UIControlState.normal)
        view.setImage(UIImage.init(named: "video_iconSXT"), for: UIControlState.highlighted)
        self.addSubview(view)
        view.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
        view.tag = ControlEvent.monitor2Video.rawValue
        return view
    }()
    
    
    convenience init(type: ControlType) {
        self.init()
        self.backgroundColor = UIColor.clear
        self.deploySubviews(type: type)
    }

    /// 配置布局子视图
    private func deploySubviews(type: ControlType){
        if type == .video {
            /// 切换语音
            voiceBTN.snp.makeConstraints { (make) in
                make.top.equalTo(24)
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
        }else{
            // 返回按钮
            cancelBTN.snp.makeConstraints { (make) in
                make.width.height.equalTo(42)
                make.left.top.equalTo(10)
            }
            
            let width = kScreenH / 3.0
            
            /// 监控切视频按钮
            monitor2VideoBTN.snp.makeConstraints { (make) in
                make.width.height.equalTo(60)
                make.bottom.equalTo(-20)
                make.centerX.equalTo(width * 0.5)
            }
            
            /// 拍照按钮
            pictureBTN.snp.makeConstraints { (make) in
                make.width.height.equalTo(60)
                make.bottom.equalTo(-20)
                make.centerX.equalTo(width * 1.5)
            }
            
            /// 录制按钮
            recordBTN.snp.makeConstraints { (make) in
                make.width.height.equalTo(60)
                make.bottom.equalTo(-20)
                make.centerX.equalTo(width * 2.5)
            }
        }
        
    }
    /// 计算图标间隔
    ///
    /// - Returns: 间隔数据
    private func interval(tag: Int)->CGFloat{
        return autoLayoutY(Y: CGFloat(tag - 3003) * 140.0)
    }
    
    @objc func buttonAction(sender: UIButton){
        if let delegate = delegate{
            delegate.action(sender: sender, type: KPEMVideoControlView.ControlEvent.init(rawValue: sender.tag))
        }
    }
}
