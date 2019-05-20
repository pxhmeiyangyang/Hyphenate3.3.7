//
//  KPLinkManVC.swift
//  EMChat
//
//  Created by pxh on 2019/5/20.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

/// 联系人界面
class KPLinkManVC: UIViewController {

    /// 列表
    lazy var tableview: UITableView = {
        let view = UITableView()
        self.view.addSubview(view)
        view.tableFooterView = UIView()
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = UITableViewCellSeparatorStyle.none
        view.backgroundColor = UIColor.clear
        view.register(KPLinkManCell.self, forCellReuseIdentifier: "KPLinkManCell")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "联系人"
        deploySubviews()
    }
    
    /// 配置子页面
    private func deploySubviews(){
        tableview.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension KPLinkManVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(KPChatVC.init(conversationChatter: testEMName, conversationType: EMConversationTypeChat), animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return KPLinkManCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "KPLinkManCell", for: indexPath) as? KPLinkManCell else { return UITableViewCell() }
        return cell
    }
    
    
}
