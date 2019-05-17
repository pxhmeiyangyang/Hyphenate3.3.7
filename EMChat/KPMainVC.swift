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
//        KPChatVC.init(conversationChatter: "123456789", conversationType: EMConversationTypeChat)
        self.title = "环信聊天"
        tableview.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension KPMainVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch datas[indexPath.row] {
        case "语聊":
            self.navigationController?.pushViewController(KPChatVC.init(conversationChatter: "123456789", conversationType: EMConversationTypeChat), animated: true)
        case "视频":
            break
        case "监控":
            break
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
