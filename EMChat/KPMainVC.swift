//
//  KPMainVC.swift
//  EMChat
//
//  Created by pxh on 2019/5/17.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit
import SnapKit

/// 主页内容
class KPMainVC: UIViewController {

    /// 数据表
    private let datas = ["语聊","视频","监控"]
    
    /// 列表视图
    lazy var tableview: UITableView = {
        let view = UITableView()
        self.view.addSubview(view)
        view.delegate = self
        view.dataSource = self
        view.tableFooterView = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "环信聊天"
        tableview.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        guard let test = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return }
        let path = test + "/1.mp4"
        //                try data.write(to: URL.init(fileURLWithPath: path))
        PhotoAlbumUtil.saveVideo(path: path, albumName: photoAlbumName) { (error) in
            print(error)
        }
        
        let path2 = test + "/2.mkv"
        //                try data.write(to: URL.init(fileURLWithPath: path))
        PhotoAlbumUtil.saveVideo(path: path2, albumName: photoAlbumName) { (error) in
            print(error)
        }
        
        let path3 = test + "/3.mp4"
        //                try data.write(to: URL.init(fileURLWithPath: path))
        PhotoAlbumUtil.saveVideo(path: path3, albumName: photoAlbumName) { (error) in
            print(error)
        }
    }
    
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension KPMainVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch datas[indexPath.row] {
        case "语聊":
            self.navigationController?.pushViewController(KPLinkManVC(), animated: true)
        case "视频":
            KPEMChatHelper.present1v1VideoCall()
        case "监控":
            self.navigationController?.pushViewController(KPEMMonitoringVC(), animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = datas[indexPath.row]
        return cell!
    }
}
